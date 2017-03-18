import Vue from 'vue'
import { resolve, dirname } from 'path'

Plugin = {}

Plugin.install = (vue, options) ->

  vue.mixin
    created: () ->
      # console.log @$options.module
      if @$options.module
        Meteor.registerModule @$options.module
    methods:
      $call: (args...) ->
        if @$options.meteor.server?
          name = args.shift()
          _name = resolve(dirname(@$options.module.id), @$options.meteor.server)
            .replace('/node_modules/meteor/mrmasly:vision/app', 'vision')
            .replace('/app/', 'app/')
            .replace('/index.coffee.js', '')
            .replace('.js', '')
            .replace('.coffee', '')
          name = "#{_name}--method--#{name}"
          args.unshift(name)
        Meteor.call args...

Vue.use Plugin
