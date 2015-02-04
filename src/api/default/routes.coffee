module.exports = (app) ->
  app.get '/api', (req, res) ->
    res.send 'Arse'
    console.log 'woot'
    return
