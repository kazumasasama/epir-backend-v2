class PaymentsController < ApplicationController
  
  def checkout
    ids = params[:id].map{|id| id}
    menus = Menu.where(id: ids)
    
    service_tax = Stripe::TaxRate.create(
      {
        display_name: 'Service Tax',
        inclusive: false,
        percentage: 4.5,
        country: 'US',
        state: 'NY',
        jurisdiction: 'US - NY',
        description: 'NY Service Tax',
      },
    )

    line_items = menus.map{|menu| {
      price_data: {
        currency: 'usd',
        product_data: {
          name: menu.title,
        },
        unit_amount: (menu.price * 100).to_i,
      },
      quantity: 1,
      tax_rates: [service_tax],
    }}

    Stripe.api_key = Rails.application.credentials.STRIPE_TEST_API_KEY
    session = Stripe::Checkout::Session.create({
      line_items: line_items,
      mode: 'payment',
      # These placeholder URLs will be replaced in a following step.
      success_url: 'http://localhost:8080/complete',
      cancel_url: 'http://localhost:8080/appointments',
    })
    render json: session
  end

  def secret
    menu_ids = params[:menuIds]
    menus = Menu.where(id: menu_ids)
    tax = params[:tax]
    charge_amount = ((menus.map{|menu| menu.price}.sum + tax) * 100).round(0)

    Stripe.api_key = Rails.application.credentials.STRIPE_TEST_API_KEY

    intent = Stripe::PaymentIntent.create(
        amount: charge_amount,
        currency: 'usd',
        automatic_payment_methods: {enabled: true},
        
    )
    render json: intent.client_secret.as_json
  end

end