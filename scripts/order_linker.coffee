# Description:
#   Converts order number patterns into clickable links
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   <wXXXXXXX> - Return a Whole Latte Love link
#   <AXXXXXXX> - Return an Aabree link
#   <EXXXXXXX> - Return an Essential Espresso link
#   <MXXXXXXX> - Return an Empire (M-pire) link
#   <IXXXXXXX> - Return an Importika link
#   <RXXXXXXXXX> - Return a Spree link
#   hubot pug bomb N - get N pugs

module.exports = (robot) ->
  COMPANIES =
    R : "spree"
    W : "wholelattelove"

  robot.respond /([a-z])(\d{7,9})\b/i, (msg) ->
    company = COMPANIES[msg.match[2]]
    msg.send "That's a #{company} order"

  robot.respond /pug bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    msg.http("http://pugme.herokuapp.com/bomb?count=" + count)
      .get() (err, res, body) ->
        msg.send pug for pug in JSON.parse(body).pugs

  robot.respond /how many pugs are there/i, (msg) ->
    msg.http("http://pugme.herokuapp.com/count")
      .get() (err, res, body) ->
        msg.send "There are #{JSON.parse(body).pug_count} pugs."

