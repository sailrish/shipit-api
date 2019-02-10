shipper = require './shipper'
guessCarrier = shipper.guessCarrier
{map} = require 'underscore'

class CarrierFactory
  UPS = 0
  ENSENDA = 1
  FEDEX = 2
  USPS = 3
  LASERSHIP = 4
  ONTRAC = 5
  DHL = 6
  UPSMI = 7
  AMAZON = 8
  A1INTL = 9
  DHLGM = 10
  PRESTIGE = 11
  CANADAPOST = 12

  CARRIER =
    0: "UPS"
    1: "Ensenda"
    2: "FedEx"
    3: "USPS"
    4: "LaserShip"
    5: "OnTrac"
    6: "DHL"
    7: "UPS Mail Inn."
    8: "Amazon"
    9: "A1 Intl."
    10: "DHL Global Mail"
    11: "Prestige"
    12: "Canada Post"

  CARRIER_URL =
    "UPS": "http://wwwapps.ups.com/WebTracking/track?track=yes&trackNums="
    "FedEx": "https://www.fedex.com/apps/fedextrack/?tracknumbers="
    "USPS": "https://tools.usps.com/go/TrackConfirmAction?qtc_tLabels1="
    "LaserShip": "http://www.lasership.com/track/"
    "OnTrac": "http://www.ontrac.com/trackingres.asp?tracking_number="
    "UPS Mail Inn.": "https://www.ups-mi.net/packageID/PackageID.aspx?PID="
    "A1 Intl.": "http://www.aoneonline.com/pages/customers/trackingrequest.php?tracking_number="
    "Canada Post": "http://www.canadapost.ca/cpotools/apps/track/personal/findByTrackNumber?trackingNumber="
    "DHL Global Mail": "http://webtrack.dhlglobalmail.com/?trackingnumber="
    "DHL": "http://www.dhl.com/cgi-bin/tracking.pl?AWB="
    "Prestige": "http://www.prestigedelivery.com/trackpackage.aspx?trackingNumbers="

  UPS_CLIENT = shipper.upsClient
  FEDEX_CLIENT = shipper.fedexClient
  USPS_CLIENT = shipper.uspsClient
  DHL_CLIENT = shipper.dhlClient
  LASERSHIP_CLIENT = shipper.lsClient
  ON_TRAC_CLIENT = shipper.onTracClient
  UPSMI_CLIENT = shipper.upsmiClient
  AMAZON_CLIENT = shipper.amazonClient
  A1_CLIENT = shipper.a1Client
  CANADAPOST_CLIENT = shipper.canpostClient
  DHLGM_CLIENT = shipper.dhlgmClient
  PRESTIGE_CLIENT = shipper.prestigeClient

  CARRIER_CLIENT =
    'ups': UPS_CLIENT
    'fedex': FEDEX_CLIENT
    'usps': USPS_CLIENT
    'dhl': DHL_CLIENT
    'lasership': LASERSHIP_CLIENT
    'ontrac': ON_TRAC_CLIENT
    'upsmi': UPSMI_CLIENT
    'amazon': AMAZON_CLIENT
    'a1intl': A1_CLIENT
    'canadapost': CANADAPOST_CLIENT
    'dhlgm': DHLGM_CLIENT
    'prestige': PRESTIGE_CLIENT

  CARRIER_ID =
    'ups': UPS
    'fedex': FEDEX
    'usps': USPS
    'dhl': DHL
    'lasership': LASERSHIP
    'ontrac': ONTRAC
    'upsmi': UPSMI
    'amazon': AMAZON
    'a1intl': A1INTL
    'canadapost': CANADAPOST
    'dhlgm': DHLGM
    'prestige': PRESTIGE

  constructor: ->
    @CARRIER_BY_ID = {}
    @CARRIER_BY_ID[UPS] = 'ups'
    @CARRIER_BY_ID[FEDEX] = 'fedex'
    @CARRIER_BY_ID[USPS] = 'usps'
    @CARRIER_BY_ID[DHL] = 'dhl'
    @CARRIER_BY_ID[LASERSHIP] = 'lasership'
    @CARRIER_BY_ID[ONTRAC] = 'ontrac'
    @CARRIER_BY_ID[UPSMI] = 'upsmi'
    @CARRIER_BY_ID[AMAZON] = 'amazon'
    @CARRIER_BY_ID[A1INTL] = 'a1intl'
    @CARRIER_BY_ID[CANADAPOST] = 'canadapost'
    @CARRIER_BY_ID[DHLGM] = 'dhlgm'
    @CARRIER_BY_ID[PRESTIGE] = 'prestige'

  getCarrier: (carrier) ->
    client = CARRIER_CLIENT[carrier]

  getCarrierUrl: (carrier_name, tracking_number) ->
    url = CARRIER_URL[carrier_name]
    return null unless url?
    return "#{url}#{tracking_number}"

  getCarrierList: ->
    map @CARRIER_BY_ID, (name, id) -> name

  getCarrierName: (id) ->
    carrier = @CARRIER_BY_ID[id]

  detectCarrier: (trk) ->
    carriers = guessCarrier trk
    return unless carriers?.length
    map carriers, (c) -> CARRIER_ID[c]

  getCarrierId: (carrier) ->
    CARRIER_ID[carrier]

  getCarrierStringByName: (name) ->
    @getCarrierString @getCarrierId name

  getCarrierString: (id) ->
    str = CARRIER[id]
    str ?= 'Unknown'

  getRequestOptions: (params) ->
    return {trackingNumber: params.trackingNumber} unless params.carrier is 'amazon'
    amazonFields = params.trackingNumber.split ':'
    orderID = amazonFields[0]
    orderingShipmentId = amazonFields[1]
    {orderID, orderingShipmentId}


module.exports = {CarrierFactory}
