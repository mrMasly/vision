import Vue from 'vue'
import { resolve, dirname } from 'path'

Plugin = {}

Plugin.install = (vue, options) ->

  vue.mixin
    methods:
      $call: (args...) ->
        if @$options.meteor.server?
          name = args.shift()
          _name = resolve(dirname(@$options.module.id), @$options.meteor.server)
            .replace('/node_modules/meteor/mrmasly:vision/components', 'vision')
            .replace('/components/', 'app/')
            .replace('/index.coffee.js', '')
            .replace('.js', '')
            .replace('.coffee', '')
          name = "#{_name}--method--#{name}"
          args.unshift(name)
        # console.log args
        Meteor.call args...

Vue.use Plugin
