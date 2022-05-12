require 'stripe'
require 'sinatra'

# This is your test secret API key.
Stripe.api_key = 'sk_test_51KyG1IDSLS6ogZyWUbPgtqfGP5BiavUoEaRWrjpTzPud7N6cJ9dP5YIdCumHrDKck8joYJhKobseEiULPHOFXKER00SpcCQa4r'

set :static, true
set :port, 4242

YOUR_DOMAIN = 'http://localhost:8080'

post '/create-checkout-session' do
  content_type 'application/json'

  session = Stripe::Checkout::Session.create({
    line_items: [{
      # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
      price: 'price_1KyIZdDSLS6ogZyWSOVq5myT',
      quantity: 1,
    }],
    mode: 'payment',
    success_url: YOUR_DOMAIN + '/complete',
    cancel_url: YOUR_DOMAIN + '/appointments',
  })
  redirect session.url, 303
end