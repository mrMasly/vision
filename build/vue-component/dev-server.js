/*
LICENCE ISC - Created by Guillaume CHAU (@Akryum)
https://github.com/Akryum/vue-meteor
*/

import http from 'http';
import socket_io from 'socket.io';
import {Meteor} from 'meteor/meteor';

if(global._dev_server_http) {
  global._dev_server.close();
  global._dev_server_http.close();
  delete global._dev_server;
  delete global._dev_server_http;
}

if(Meteor.isDevelopment) {
  var server = http.createServer();
  var io = socket_io(server, {
    serveClient: false,
  });

  // Stored dynamic styles
  io.__styles = {};
  io.__addStyle = function({hash, css, path}, emit = true) {
    if(emit) {
      io.emit('css', {hash, css, path});
    }
    io.__styles[hash] = {
      hash,
      css,
      path
    };
  };

  // Send all stored dynamic styles to new clients
  io.on('connection', function (socket) {
    for(var hash in io.__styles) {
      socket.emit('css', io.__styles[hash]);
    }
  });

  function getMeteorPort() {
    const argv = this.process.argv;
    let index = argv.indexOf('--port');
    if(index === -1) {
      index = argv.indexOf('-p');
    }
    if(index !== -1 && argv.length > index) {
      return parseInt(argv[index+1])+3;
    }
  }

  PORT = parseInt(process.env.HMR_PORT) || parseInt(process.env.VUE_DEV_SERVER_PORT) || getMeteorPort() || 3003;

  try {
    server.listen(PORT);
    if (process.stdout.clearLine) {
        process.stdout.clearLine();
    }
    process.stdout.write(`\r   [HMR] Dev server listening on port ${PORT}\n`);
    global._dev_server = io;
    global._dev_server_http = server;
  } catch(e) {
    console.log(e);
  }
}
