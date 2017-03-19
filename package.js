Package.describe({
  name: 'mrmasly:vision',
  version: '0.1.2',
  summary: 'Vision app',
  git: 'https://github.com/mrMasly/vision',
  documentation: 'README.md'
});

Package.registerBuildPlugin({
  name: "compileCoffeescript",
  use: ['caching-compiler', 'ecmascript'],
  sources: ['build/coffeescript/compile.js'],
  npmDependencies: {
    "coffee-script": "1.12.4",
    "source-map": "0.5.6"
  }
});

/*
LICENCE ISC - Created by Guillaume CHAU (@Akryum)
https://github.com/Akryum/vue-meteor
*/
Package.registerBuildPlugin({
  name: "vue-component",
  use: [
    'ecmascript@0.6.3',
    'caching-compiler@1.1.9',
    'babel-compiler@6.13.0',
  ],
  sources: [
    'build/vue-component/regexps.js',
    'build/vue-component/utils.js',
    'build/vue-component/dev-server.js',
    'build/vue-component/post-css.js',
    'build/vue-component/tag-scanner.js',
    'build/vue-component/tag-handler.js',
    'build/vue-component/vue-compiler.js',
    'build/vue-component/plugin.js'
  ],
  npmDependencies: {
    'postcss': '5.2.15',
    'postcss-selector-parser': '2.2.3',
    'postcss-modules': '0.6.4',
    'socket.io': '1.7.3',
    'async': '2.1.5',
    'lodash': '4.17.4',
    'hash-sum': '1.0.2',
    'source-map': '0.5.6',
    'source-map-merger': '0.2.0',
    'generate-source-map': '0.0.5',
    'autoprefixer': '6.7.5',
    'vue-template-compiler': '2.2.4',
    'vue-template-es2015-compiler': '1.5.1',
  }
});


Package.registerBuildPlugin({
  name: "vue-component-stylus",
  use: [ 'ecmascript@0.6.3' ],
  sources: [ 'build/vue-stylus.js' ],
  npmDependencies: {
    stylus: "0.54.5",
    nib: "1.1.2"
  }
});

Package.registerBuildPlugin({
  name: "vue-component-coffee",
  use: [ 'ecmascript@0.6.3' ],
  sources: [ 'build/vue-coffee.js' ],
  npmDependencies: {
    'coffee-script': '1.12.4',
    'source-map': '0.5.6'
  }
});

Package.registerBuildPlugin({
  name: "vue-component-jade",
  use: [ 'ecmascript@0.6.3' ],
  sources: [ 'build/vue-jade.js' ],
  npmDependencies: {
    'jade': '1.11.0'
  }
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
