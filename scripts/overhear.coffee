# Description:
#   Listen for phrases and respond
#
# Commands:
#   none
#
# Author:
#   Ryan Winchester <fungku@gmail.com>

channels = process.env.WHITELIST_CHANNELS.split(',')

module.exports = (robot) ->

    # Regex problem
    robot.hear /use regex/i, (msg) ->
      if msg.message.room in channels
        msg.send 'Some people, when confronted with a problem, think "I know, I\'ll use regular expressions." Now they have two problems.'

    # just do it
    robot.hear /^just do it(.{1,10})?$/i, (msg) ->
      if msg.message.room in channels
        msg.send "https://www.youtube.com/watch?v=hAEQvlaZgKY"

    # don't get the joke
    robot.hear /(((i don'?t get)|(.* doesn'?t get)|(didn'?t get)) (the joke))|wh?oosh/i, (msg) ->
      if msg.message.room in channels
        msg.send "https://s3-us-west-2.amazonaws.com/sevenshores/gif/Joke-Goes-Over-Your-Head-Star-Trek-Gif.gif"

    # that's what she said
    robot.hear /that('s| is)( a)? (big|small|large|huge|tiny)/i, (msg) ->
      if msg.message.room in channels
        msg.reply "That's what she said."
