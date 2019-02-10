{
  UpsClient,
  FedexClient,
  UspsClient,
  DhlClient,
  LasershipClient,
  OnTracClient,
  UpsMiClient,
  AmazonClient,
  A1Client,
  CanadaPostClient,
  DhlGmClient,
  PrestigeClient,
  guessCarrier
} = require 'shipit'

upsClient = new UpsClient
  licenseNumber: process.env.UPS_LICENSE
  userId: process.env.UPS_USER_ID
  password: process.env.UPS_PASSWORD

fedexClient = new FedexClient
  key: process.env.FEDEX_KEY
  password: process.env.FEDEX_PASSWORD
  account: process.env.FEDEX_ACCOUNT
  meter: process.env.FEDEX_METER

uspsClient = new UspsClient
  userId: process.env.USPS_USER_ID
  clientIp: process.env.USPS_CLIENT_IP

dhlClient = new DhlClient
  userId: process.env.DHL_USER_ID
  password: process.env.DHL_PASSWORD

lsClient = new LasershipClient()

onTracClient = new OnTracClient()

upsmiClient = new UpsMiClient()

amazonClient = new AmazonClient()

a1Client = new A1Client()

canpostClient = new CanadaPostClient
  username: process.env.CANADA_POST_USER
  password: process.env.CANADA_POST_PASSWORD

dhlgmClient = new DhlGmClient()

prestigeClient = new PrestigeClient()

module.exports = {
  upsClient,
  fedexClient,
  uspsClient,
  dhlClient,
  lsClient,
  onTracClient,
  upsmiClient,
  amazonClient,
  a1Client,
  canpostClient,
  dhlgmClient,
  prestigeClient,
  guessCarrier
}
