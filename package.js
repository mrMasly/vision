Package.describe({
  name: 'mrmasly:vision',
  version: '0.5.0',
  summary: 'Vision app',
  git: 'https://github.com/mrMasly/vision',
  documentation: 'README.md'
});

Package.registerBuildPlugin({
  name: 'theme-compiler',
  use: ['ecmascript', 'caching-compiler'],
  sources: [
    'build/theme.js'
  ],
  npmDependencies: {
    stylus: "https://github.com/meteor/stylus/tarball/bb47a357d132ca843718c63998eb37b90013a449", // fork of 0.54.5
    nib: "1.1.2",
    "autoprefixer-stylus": "0.9.4"
  }
})



Package.onUse(function(api) {
  api.versionsFrom('1.4.3.1');
  api.use('isobuild:compiler-plugin@1.0.0')

  api.use('akryum:npm-check@0.0.2');
  api.use('coffeescript@1.12.3_1');

  api.use('mrmasly:barcode@0.0.1');

  api.use('ecmascript@0.6.3');
  api.use('webapp@1.3.14');
  api.use('mongo@1.1.16', ['client', 'server']);
  api.use('tmeasday:check-npm-versions@0.3.1');
  api.use('stylus');
  api.use('meteorhacks:async@1.0.0');
  api.use('zimme:collection-behaviours@1.1.3');
  api.use('random@1.0.10');

  api.use('accounts-base@1.2.15');
  api.use('accounts-password@1.3.4');

  api.use('mrmasly:vue@0.2.6');
  api.use('mrmasly:files@0.0.3');

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


  api.addFiles([
    'styles/index.styl'
  ]);

  api.addFiles('main/common.coffee', ['client', 'server']);
  api.addFiles('main/client.coffee', 'client');
  api.addFiles('main/server.coffee', 'server');

});
