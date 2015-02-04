module.exports = (app) ->
  require('./default/routes')(app)
  require('./hull_classes/routes')(app)
