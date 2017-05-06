Package.describe({
  name: 'mrmasly:vision-tasks',
  version: '0.0.1',
  summary: 'Vision tasks',
  git: 'https://github.com/mrMasly/vision',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.4.3.1');

  api.use('akryum:npm-check@0.0.2');
  api.use('coffeescript@1.12.3_1');
  api.use('ecmascript@0.6.3');
  api.use('mongo@1.1.16', ['client', 'server']);


  api.use('zimme:collection-behaviours@1.1.3');
  api.use('zimme:collection-timestampable@1.0.9');


  api.use('accounts-base@1.2.15');
  api.use('accounts-password@1.3.4');

  api.use('mrmasly:vue@0.2.2');


  api.addFiles('index.coffee', ['client', 'server']);
  api.addFiles('./server/index.coffee', 'server');

});
