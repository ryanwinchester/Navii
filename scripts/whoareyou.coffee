# Description:
#   Tell people about the bot
#
# Commands:
#   hubot who are you

module.exports = (robot) ->

  whoiam = "I'm Navii the fairy! The Great Deku Tree (and the Flashtag team) asked me to be your partner from now on! Nice to meet you!"

  robot.respond /who (?:the .* )?are you\??$/i, (msg) ->
    msg.reply whoiam

  robot.hear /who (?:the .* )?is Navii\??/i, (msg) ->
    msg.reply whoiam

  # robot.respond /which version\??$/i, (msg) ->
  #   version = process.env.HUBOT_GIT_SHA || false
  #
  #   if version
  #     msg.reply "I'm currently on SHA #{version}."
  #   else
  #     msg.reply "Someone needs to store a magical incantation to
  #                the HUBOT_GIT_SHA env var so I can look this up"
