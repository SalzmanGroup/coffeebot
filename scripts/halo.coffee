# Description
#   A Hubot script to show incentive progress.
#
# Configuration:
#   <none>
# Commands:
#   <none>
#
# Author:
#   Kyle Macey <shout@kylemacey.com>
#

module.exports = (robot) ->

  storage = robot.brain.data.halo ||= {
    last_year_month_total: 0
    month_to_date: 0
    last_year_month_today: 0
    today: 0
    b1: 0
    b2: 0
    b3: 0
  }

  robot.respond /halo help/, (msg)->
    return unless robot.auth.hasRole(msg.envelope.user,'halo')
    msg.send 'Usage: "halo set [LAST YEAR MONTH TOTAL] [THIS YEAR MONTH TO DATE] [LAST MONTH DAY] [YESTERDAY]"'
    msg.send 'Whole dollar amounts only, no punctuation or dollar signs'
    msg.send 'Example:'
    msg.send '`coffeebot halo set 850000 230000 56000 34000`'

  robot.respond /halo set bonus (\d+) (\d+) (\d+)/, (msg) ->
    return unless robot.auth.hasRole(msg.envelope.user,'halo')
    [_, b1, b2, b3] = msg.match

    storage["b1"] = b1
    storage["b2"] = b2
    storage["b3"] = b3


  robot.respond /halo set (\d+) (\d+) (\d+) (\d+)/, (msg) ->
    return unless robot.auth.hasRole(msg.envelope.user,'halo')
    [_, last_year_month_total, month_to_date, last_year_month_today, today] = msg.match
    msg.send "last_year_month_total: #{last_year_month_total}"
    msg.send "month_to_date: #{month_to_date}"
    msg.send "last_year_month_today: #{last_year_month_today}"
    msg.send "today: #{today}"

    storage["last_year_month_total"] = last_year_month_total
    storage["month_to_date"] = month_to_date
    storage["last_year_month_today"] = last_year_month_today
    storage["today"] = today

  robot.respond /halo update/, (msg)->
    day = new Date().getDate()
    last_year_expectation = (storage.last_year_month_total * day/30)
    trend_month_to_date = (storage.month_to_date / last_year_expectation - 1)
    trend_today = (storage.today / storage.last_year_month_today - 1)
    trend_month_overall = storage.month_to_date / storage.last_year_month_total
    msg.send "Yesterday's percentage of goal: #{Math.round(trend_today * 1000) / 10}%"
    msg.send "This month's trending percentage of goal: #{Math.round(trend_month_to_date * 1000) / 10}%"
    msg.send "This month's percentage of goal: #{Math.round(trend_month_overall * 1000) / 10}%"
    msg.send "Bonus level 1: 5% - $#{storage.b1}"
    msg.send "Bonus level 2: 10% - $#{storage.b2}"
    msg.send "Bonus level 3: 20% - $#{storage.b3}"
