const lynx = require('lynx');

// instantiate a metrics client
// Note: the metric hostname is hardcoded here

const ENVIRONMENT = typeof process.env.ENVIRONMENT === 'undefined' ? 'dev' : process.env.ENVIRONMENT;
const STATSD_PORT = typeof process.env.STATSD_PORT === 'undefined' ? 8125 : parseInt(process.env.STATSD_PORT);
const STATSD_URL = typeof process.env.STATSD_URL === 'undefined' ? 'localhost' : process.env.STATSD_URL;

const metrics = new lynx(STATSD_URL, STATSD_PORT);

// sleep for a given number of milliseconds
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function main() {
  // send message to the metrics server
  metrics.timing('test.core.delay', Math.random() * 1000);
  console.log('[DEBUG] Sending to metric server');
  // sleep for a random number of milliseconds to avoid flooding metrics server
  return sleep(3000);
}

// infinite loop
(async () => {
  console.log("🚀🚀🚀");
  console.log('[INFO] Run with env: ' + ENVIRONMENT);
  console.log('[INFO] Target URL is: ' + STATSD_URL);
  console.log('[INFO] Target port is: ' + STATSD_PORT);
  while (true) { await main() }
})()
  .then(console.log, console.error);
