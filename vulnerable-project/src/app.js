// A tiny demo app. It only prints text and never touches the network.
const { appName, version } = require('./config');

function greeting() {
  return `Hello from ${appName} v${version}.`;
}

function main() {
  console.log(greeting());
}

main();
