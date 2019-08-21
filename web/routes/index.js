var express = require('express');
var os = require('os');
var router = express.Router();
var request = require('request');


var api_url = process.env.API_HOST + '/api/status';


//healthcheck, to route traffic to healty hosts
router.get('/healthz', function(req, res) {
  return res.status(200).json({
    status: "still alive ;)"
  });
});
/* GET home page. */
router.get('/', function(req, res, next) {
  request(
    {
      method: 'GET',
      url: api_url,
      json: true
    },
    function (error, response, body) {
      if (error || response.statusCode !== 200) {
        return res.status(500).send('error running request to ' + api_url);
      } else {
        res.render('index', {
          title: '3tier App' ,
          request_uuid: body.request_uuid,
          time: body.time,
          hostname: os.hostname()
        });
      }
    }
  );
});

module.exports = router;
