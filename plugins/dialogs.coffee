import Vue from 'vue'
import _ from 'lodash'

Plugin = {}

component = ->
  children = Meteor.app.$children[0].$children
  _.find children, _name: '<Dialogs>'

Plugin.install = (vue, options) ->

  vue.mixin
    methods:
      $alert: (args...) ->
        component().openAlert args...
      $confirm: (args...) ->
        component().openConfirm args...
      $prompt: (args...) ->
        component().openPrompt args...


Vue.use Plugin
