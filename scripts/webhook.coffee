
module.exports = (robot) ->
  robot.router.get '/hubot/myface', (req, res) ->
    robot.send "HELLO, webhook been hit, yo"
    res.send 'OK'
