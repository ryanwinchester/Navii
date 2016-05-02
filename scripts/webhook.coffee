
rooms = ['flashtag', 'flashtag-offtopic']

module.exports = (robot) ->
  robot.router.get '/hubot/say-to-room/:room', (req, res) ->
    room = req.params.room
    if room not in rooms
        res.send "Invalid room"
    else
        robot.messageRoom room, "HELLO, webhook been hit, yo"
        res.send 'OK'
