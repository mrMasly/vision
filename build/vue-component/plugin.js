/*
LICENCE ISC - Created by Guillaume CHAU (@Akryum)
https://github.com/Akryum/vue-meteor
*/
Plugin.registerCompiler({
  extensions: ['vue'],
  filenames: [IGNORE_FILE],
  archMatching: 'web'
}, () => new VueComponentCompiler());

global.vue = global.vue || {}
global.vue.lang = global.vue.lang || {}
