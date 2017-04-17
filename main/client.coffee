import jQuery from 'jquery'
import Croppie from 'croppie/croppie.js'
import 'croppie/croppie.css'

window.$ = window.jQuery = jQuery
window.Croppie = Croppie

import Vue from 'vue'
import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.css'

Vue.use(VueMaterial)
Vue.material.registerTheme 'default',
  primary: 'blue'
  accent: 'red'
  warn: 'red'
  background: 'white'


import '@mrmasly/layout'


import './store.coffee'
import '../styles/material/index.styl'
import '../plugins/index.coffee'
