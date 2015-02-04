express     = require 'express'
app         = express()
router      = express.Router()
require('./api/routes')(app)

app.listen 3000
