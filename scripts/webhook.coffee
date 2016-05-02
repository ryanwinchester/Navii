
module.exports = (robot) ->
  robot.router.get '/hubot/say-to-room/:room', (req, res) ->
    room = req.params.room
    if (room != 'flashtag' || room != 'flashtag-offtopic')
        res.send 'Not a valid room'
    robot.messageRoom room, "HELLO, webhook been hit, yo"
    res.send 'OK'
