import '../collections/index.coffee'
# Meteor.ssr = no

import Vue from 'vue'

import '../theme/index.js'
import './store.coffee'
import '../plugins/index.coffee'
import '../components/index.coffee'
import '../filters/index.coffee'
import '../directives/index.coffee'

Barcode.error = (code) ->
  Meteor.Vue.$toast
    text: "Штрихкод не найден: #{code}"
    position: 'bottom right'
