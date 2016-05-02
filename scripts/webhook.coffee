
rooms = ['flashtag', 'flashtag-offtopic']

module.exports = (robot) ->
  robot.router.get '/hubot/say-to-room/:room', (req, res) ->
    room = req.params.room
    IP = req.headers['x-forwarded-for'] || req.connection.remoteAddress
    if room not in rooms
        res.send "Invalid room"
    else
        robot.messageRoom "##{room}", "HELLO, webhook been hit, by #{IP}"
        res.send 'OK'
