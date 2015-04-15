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
    "R" : "http://www.wholelattelove.com/admin/orders/RNUMBER/edit"
    "W" : "wholelattelove"

  robot.hear /([a-z])(\d{7,9})\b/i, (msg) ->
    link = COMPANIES[msg.match[1]]
    msg.send link.replace('NUMBER', msg.match[2])

