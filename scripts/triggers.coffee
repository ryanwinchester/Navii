# Description:
#   Listen for triggers and give the response
#
# Configuration
#   HUBOT_TRIGGER_CHAR - The character you want to use to identify a trigger.
#                        Defaults to !
#
# Commands:
#   !<trigger>
#   bubo list triggers
#
# Author:
#   Ryan Winchester <code@ryanwinchester.ca>

trigger_char = process.env.HUBOT_TRIGGER_CHAR || '!'
triggers = require('../support/triggers')

module.exports = (robot) ->

  robot.respond /list triggers/, (res) ->
    res.send ("#{trigger_char}#{key}" for own key of triggers).join(", ")

  robot.hear ///^#{trigger_char}(.+)$///gi, (res) ->
    if res.message.room == '#flashtag' or res.message.room == 'Shell'
      match = res.match[0].replace(///^#{trigger_char}///, "")
      if triggers[match]?
        res.send triggers[match]
