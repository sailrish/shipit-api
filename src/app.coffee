logfmt = require 'logfmt'
cluster = require 'cluster'
favicon = require 'serve-favicon'
log = require './helpers/log'
carrierController = require './controllers/carrier'

MAX_WORKERS = 4

if (cluster.isMaster)
  cpus = require('os').cpus().length
  cpus = MAX_WORKERS if cpus > MAX_WORKERS

  for i in [1..cpus]
    cluster.fork()

  cluster.on 'exit', (worker, code, signal) ->
    log.error 'app', null, {msg: 'Worker died, restarting.', id: worker.id, code: code, signal: signal}
    cluster.fork()

else
  express = require 'express'
  bodyParser = require 'body-parser'

  app = express()

  app.use logfmt.requestLogger()
  app.use bodyParser.urlencoded({limit: '50mb', extended: true})
  app.use bodyParser.json({limit: '50mb'})
  app.use '/public', express.static('public')
  app.use favicon "#{__dirname}/../public/images/favicon.ico"

  app.get '/api/carriers/:carrier/:trackingNumber', carrierController.show
  app.get '/api/guess/:trackingNumber', carrierController.guess

  port = process.env.PORT || 5000
  app.listen port, () ->
    log.info 'app', null, {msg: 'Worker started', port: port, id: cluster.worker.id}

