Package.describe({
  name: 'mrmasly:vision',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.registerBuildPlugin({
  name: "vue-component-stylus",
  use: [ 'ecmascript@0.6.3' ],
  sources: [ 'syntax/vue-stylus.js' ],
  npmDependencies: {
    stylus: "0.54.5",
    nib: "1.1.2"
  }
});

Package.registerBuildPlugin({
  name: "vue-component-coffee",
  use: [ 'ecmascript@0.6.3' ],
  sources: [ 'syntax/vue-coffee.js' ],
  npmDependencies: {
    'coffee-script': '1.12.4',
    'source-map': '0.5.6'
  }
});

Package.registerBuildPlugin({
  name: "vue-component-jade",
  use: [ 'ecmascript@0.6.3' ],
  sources: [ 'syntax/vue-jade.js' ],
  npmDependencies: {
    'jade': '1.11.0'
  }
});


Package.onUse(function(api) {
  api.versionsFrom('1.4.3.1');
  api.use('akryum:vue-component@0.8.9');

  api.use('coffeescript@1.12.3_1');
  api.use('ecmascript@0.6.3');
  api.use('webapp@1.3.14');
  api.use('mongo@1.1.16', ['client', 'server'])
  api.use('tmeasday:check-npm-versions@0.3.1');
  api.use('fourseven:scss@4.5.0');
  api.use('stylus@2.513.9');
  api.use('meteorhacks:async@1.0.0')

  api.use('zimme:collection-behaviours@1.1.3');
  api.use('random@1.0.10');

  api.mainModule('settings/npm.coffee', 'server');

  api.addAssets([
    'files/audio/applause.mp3',
    'files/audio/fanfar.mp3',
    'files/audio/fanfar1.mp3',
    'files/audio/fanfar2.mp3',
    'files/audio/ifeelgood.mp3',
    'files/audio/message.wav',
    'files/audio/notification.mp3',
    'files/icon.png'
  ], 'client');


  api.addFiles('settings/common/index.coffee', ['client', 'server']);
  api.addFiles('settings/client/index.coffee', 'client');
  api.addFiles('settings/server/index.coffee', 'server');




});

Package.onTest(function(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.use('mrmasly:vision');
  api.mainModule('vision-tests.js');
});
