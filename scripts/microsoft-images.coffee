# Description:
#   Allows Hubot to find relevant images
#
# Configuration:
#   HUBOT_BING_IMAGES_ACCOUNT_KEY
#   HUBOT_BING_IMAGES_ADULT "Off", "Moderate", "Strict"
#
# Commands:
#   hubot image <query> - Searches for an image from the query
#
# Author:
#   Ryan Winchester <fungku@gmail.com>

ACCOUNT_KEY = process.env.HUBOT_BING_IMAGES_ACCOUNT_KEY
ADULT = process.env.HUBOT_BING_IMAGES_ADULT || "Strict"
IMAGE_SEARCH_URL = "https://api.datamarket.azure.com/Bing/Search/v1/Image"

module.exports = (robot) ->
  robot.respond /(image|img)( me)?( -)? (.*)/i, (msg) ->
    norandom = msg.match[3]?
    query = msg.match[4]?.trim()
    auth = new Buffer(":#{ACCOUNT_KEY}").toString('base64')
    params =
      Query: "'#{query}'"
      Adult: "'#{ADULT}'"
      $format: "json"
      $top: 20
    robot.http(IMAGE_SEARCH_URL)
      .query(params)
      .headers(Authorization: "Basic #{auth}")
      .get() (err, res, body) ->
        if err
          msg.send "Failed to search: " + err
          return
        try
          images = JSON.parse(body).d.results
          image = if norandom then images[0] else msg.random images
          msg.send image.MediaUrl
        catch error
          msg.send error
          robot.emit 'error', error
