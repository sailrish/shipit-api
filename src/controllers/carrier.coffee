{CarrierFactory} = require '../helpers/carrier'
shipper = require '../helpers/shipper'
guessCarrier = shipper.guessCarrier

noErr = null


_carrierFactory = new CarrierFactory()

module.exports =
  show: (req, res) ->
    carrierClient = _carrierFactory.getCarrier req.params.carrier
    return res.status(404).send error: 'carrier not supported' unless carrierClient?

    requestOptions = _carrierFactory.getRequestOptions req.params

    carrierClient.requestData requestOptions, (err, resp) ->
      data = {error: err or 'unknown error'} if err? or !resp?
      data = data or resp
      res.status(200)
        .set('Content-Type', 'application/json')
        .send data

  guess: (req, res) ->
    res.status(200)
      .set('Content-Type', 'application/json')
      .send guessCarrier req.params.trackingNumber
