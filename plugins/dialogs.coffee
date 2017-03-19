import Vue from 'vue'
import _ from 'lodash'

Plugin = {}

Plugin.install = (vue, options) ->

  vue.mixin
    methods:
      $alert: (args...) ->
        @$store.state.components.dialogs.openAlert args...
      $confirm: (args...) ->
        @$store.state.components.dialogs.openConfirm args...
      $prompt: (args...) ->
        @$store.state.components.dialogs.openPrompt args...
      $toast: (args...) ->
        @$store.state.components.toasts.add args...

Vue.use Plugin
