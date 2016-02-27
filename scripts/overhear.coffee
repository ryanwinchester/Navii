# Description:
#   Listen for phrases and respond
#
# Commands:
#   none
#
# Author:
#   Ryan Winchester <fungku@gmail.com>

module.exports = (robot) ->

  # I miss Rommie
  robot.hear /miss Rommie/i, (msg) ->
    msg.reply "We all miss Rommie </3"
    msg.send "!missrommie"
  robot.hear /(where('s| is)|what( the (.*))? happened to) Rommie/i, (msg) ->
    msg.reply "I don't know, ask PhillSparks..."
