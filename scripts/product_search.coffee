# Description:
#   Utility to get product information
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_SPREE_API_KEY
#   HUBOT_SPREE_API_ENDPOINT
#   HUBOT_SPREE_STORE_ID
#
# Commands:
#   hubot find product <query> - returns product details if it exists
#
# Author:
#   jonmagic

module.exports = (robot) ->
  robot.respond /find product (.*)/i, (msg) ->
    query = escape(msg.match[1])
    msg.http("#{process.env.HUBOT_SPREE_API_ENDPOINT}/api/products.json?q[name_cont]=#{query}&q[stores_id_eq]=#{process.env.HUBOT_SPREE_STORE_ID}&token=#{process.env.HUBOT_SPREE_API_KEY}")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          if product = json.products.first
            msg.send "     #{process.env.HUBOT_SPREE_API_ENDPOINT}/products/#{product.slug}
   product name: #{product.name}\n
          price: #{product.display_price}\n
  total_on_hand: #{product.total_on_hand}\n
"
          else
            msg.send "No product found
\n response body: #{body}
\n request url: #{process.env.HUBOT_SPREE_API_ENDPOINT}/api/products.json?q[name_cont]=#{query}&q[stores_id_eq]=#{process.env.HUBOT_SPREE_STORE_ID}&token=#{process.env.HUBOT_SPREE_API_KEY}
"
