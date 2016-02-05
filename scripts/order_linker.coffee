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
    "R" : "https://www.wholelattelove.com/admin/orders/RNUMBER/edit"
    "A" : "https://oes.wholelattelove.com/latte/orders/index.cfm?dbprefix=aa_&orderid=NUMBER"
    "E" : "https://oes.wholelattelove.com/latte/orders/index.cfm?dbprefix=ee_&orderid=NUMBER"
    "M" : "https://oes.wholelattelove.com/latte/orders/index.cfm?dbprefix=em_&orderid=NUMBER"
    "I" : "https://oes.wholelattelove.com/latte/orders/index.cfm?dbprefix=im_&orderid=NUMBER"
    "W" : "https://oes.wholelattelove.com/latte/orders/index.cfm?dbprefix=&orderid=NUMBER"

  robot.hear /([a-z])(\d{7,9})\b/i, (msg) ->
    link = COMPANIES[msg.match[1]]

  robot.hear /([a-z])(\d{7,9})\b/i, (msg) ->
    link = COMPANIES[msg.match[1]]
    msg.send link.replace('NUMBER', msg.match[2])

