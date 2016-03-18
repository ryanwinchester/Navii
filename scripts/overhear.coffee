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

  # Regex problem
  robot.hear /use regex/i, (msg) ->
    msg.send 'Some people, when confronted with a problem, think "I know, I\'ll use regular expressions." Now they have two problems.'

  # just do it
  robot.hear /just do it/i, (msg) ->
    msg.send "https://www.youtube.com/watch?v=hAEQvlaZgKY"

  # don't get the joke
  robot.hear /(((i don'?t get)|(.* doesn'?t get)|(didn'?t get)) (the joke))|wh?oosh/i, (msg) ->
    msg.send "https://s3-us-west-2.amazonaws.com/sevenshores/gif/Joke-Goes-Over-Your-Head-Star-Trek-Gif.gif"

  # that's what she said
  robot.hear /that('s| is)( a)? (big|small|large|huge|tiny)/i, (msg) ->
    msg.reply "That's what she said."
