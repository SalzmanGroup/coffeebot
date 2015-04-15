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

module.exports = (robot) ->
  COMPANIES =
    R : "spree"
    W : "wholelattelove"

  robot.respond /([a-z])(\d{7,9})\b/i, (msg) ->
    company = COMPANIES[msg.match[2]]
    msg.send "That's a #{company} order"

