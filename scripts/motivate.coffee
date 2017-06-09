# Description:
#   A port of http://motivate.im/
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   !h5 <username> - Hubot gives the user a high five
#   ^5 <username> - Hubot gives the user a high five
#   !m <username> - Hubot encourages your user
#   !thank <username> - Hubot encourages your user
#   !thanks <username> - Hubot encourages your user
#
# Author:
#   jjasghar

channels = process.env.WHITELIST_CHANNELS.split(',')

module.exports = (robot) ->

  robot.hear /^(?:thanks|thank you|(?:good|nice) (?:work|job)),? (\w+).?$/i, (msg) ->
    if msg.message.room in channels
      user = msg.match[1]

      praise = [
          "Keep on rocking, #{user}!",
          "Keep up the great work, #{user}!",
          "You're awesome, #{user}!",
          "You're doing good work, #{user}!" # Original and inspiration
          ]

      msg.send msg.random praise

  robot.hear /^(?:\^5) (.+)$/i, (msg) ->
    if msg.message.room in channels
      user = msg.match[1]
      msg.emote "high fives #{user}"

