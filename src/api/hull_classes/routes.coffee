module.exports = (app) ->
  app.get '/api/hull_classes', (req, res) ->
    res.send [ { name: 'raider' }, { name: 'frigate' }]
    return
