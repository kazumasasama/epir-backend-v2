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

    Stripe.api_key = 'sk_test_51LbjXDJC2O51yZ855ICl8ekPxg9lO11Pr4eCJ380g8btGVa40U2gl7g7TH3BnMEJSIHrQxclgdk43IZJB9n87QEA001iGI5cLz'
    session = Stripe::Checkout::Session.create({
      line_items: line_items,
      mode: 'payment',
      # These placeholder URLs will be replaced in a following step.
      success_url: 'http://localhost:8080/complete',
      cancel_url: 'http://localhost:8080/appointments',
    })
    render json: session
  end

end