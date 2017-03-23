Package.describe({
  name: 'mrmasly:vision',
  version: '0.1.3',
  summary: 'Vision app',
  git: 'https://github.com/mrMasly/vision',
  documentation: 'README.md'
});


Package.onUse(function(api) {
  api.versionsFrom('1.4.3.1');
  // api.use('akryum:vue-component@0.8.9');
  api.use('isobuild:compiler-plugin@1.0.0');
  api.use('akryum:vue-component-dev-server@0.0.5');
  api.use('akryum:vue-component-dev-client@0.2.5');
  api.use('akryum:vue-router2@0.1.0');

  // api.use('coffeescript@1.12.3_1');
  api.use('ecmascript@0.6.3');
  api.use('webapp@1.3.14');
  api.use('mongo@1.1.16', ['client', 'server'])
  api.use('tmeasday:check-npm-versions@0.3.1');
  api.use('fourseven:scss@4.5.0');
  // api.use('stylus@2.513.9');
  api.use('meteorhacks:async@1.0.0')

  api.use('zimme:collection-behaviours@1.1.3');
  api.use('random@1.0.10');

  api.mainModule('settings/npm.coffee', 'server');


  api.addFiles([
    'styles/layouts/angular-material.layouts.css',
    'styles/layouts/angular-material.layouts.ie_fixes.css',
    'styles/material/index.styl',
    'styles/classes.styl'
  ], 'client');

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
