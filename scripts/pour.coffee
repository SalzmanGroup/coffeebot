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
#   None

module.exports = (robot) ->
  RESPONSES = [
    "http://gifsoup.com/view/984026/make-me-bad-s-2-girls-1-cup-o.gif"
    "http://ryandurgy.com/wp-content/uploads/2013/12/here-we-go-again.gif"
    "http://media.giphy.com/media/7D1ny9O48Mzgk/giphy.gif"
    "https://www.youtube.com/watch?v=lWsuokWmEZI"
  ]
  
  robot.hear /pour/i, (msg) ->
    if msg.message.user.name.toLowerCase() == "nick"
      message.send RESPONSES[Math.floor(Math.random() * RESPONSES.length)]
