
rooms = ['flashtag', 'flashtag-offtopic']

module.exports = (robot) ->
  robot.router.get '/hubot/say-to-room/:room', (req, res) ->
    room = req.params.room
    forwardedIpsStr = req.header('x-forwarded-for');
    IP = '';

    if (forwardedIpsStr) {
        IP = forwardedIps = forwardedIpsStr.split(',')[0];
    }
    if room not in rooms
        res.send "Invalid room"
    else
        robot.messageRoom "##{room}", "HELLO, webhook been hit, by #{IP}"
        res.send 'OK'
