# shipit-api
This is a simple demo app that uses [shipit](https://www.npmjs.com/package/shipit) node module to provide a standard Rest API to retrieve status of shipments from various shipping companies.

# How to use
You'll need to obtain your own credentials for all the shipping companies you want to retrieve shipment data from. Please refer to the APIs and developer documentation for the shipping companies. Note that not all shipping carriers require credentials.  Of the ones supported by shipit, only UPS, FedEx, USPS, DHL, and Canada Post require it. Set the following environment variables:
```
UPS_LICENSE
UPS_USER_ID
UPS_PASSWORD
FEDEX_KEY
FEDEX_PASSWORD
FEDEX_ACCOUNT
FEDEX_METER
USPS_USER_ID
USPS_CLIENT_IP
DHL_USER_ID
DHL_PASSWORD
CANADA_POST_USER
CANADA_POST_PASSWORD
```
This app uses Foreman, and a `Procfile` is provided to start the app. Start the app on your local machine:
```
$ npm install
$ grunt dev
$ curl 'http://localhost:8081/api/carriers/usps/9374889707090557179658'
```
Or you can use `node` directly:
```
$ npm install
$ grunt
$ node target/app.js
```
The app is also deployed on Heroku. Here's an example:
```
http://shipit-api.herokuapp.com/api/carriers/usps/9374889707090557179658
http://shipit-api.herokuapp.com/api/guess/1ZV5E9420444964064
```
