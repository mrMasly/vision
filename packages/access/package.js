Package.describe({
  name: 'mrmasly:vision-access',
  version: '0.1.2',
  summary: 'Vision access',
  git: 'https://github.com/mrMasly/vision',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.4.3.1');

  api.use('akryum:npm-check@0.0.2');
  api.use('coffeescript@1.12.3_1');
  api.use('ecmascript@0.6.3');

  api.use('accounts-base@1.2.15');
  api.use('accounts-password@1.3.4');

  api.use('mrmasly:vue@0.3.0');
  api.use('mrmasly:files@0.0.3');

  api.addFiles('Access.vue', 'client');
  api.addFiles('server/index.coffee', 'server');

});
