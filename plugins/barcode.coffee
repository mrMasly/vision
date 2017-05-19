import Vue from 'vue'
import _ from 'lodash'

if Meteor.isClient
  chars = []

  Barcode =
    _codes: {}
    _callbacks: {}
    on: (type, cb) ->
      @_callbacks[type] ?= []
      @_callbacks[type].push cb
    off: (type, cb) ->
      @_callbacks[type] ?= []
      @_callbacks[type] = _.without @_callbacks[type], cb
    add: (type, code, data) ->
      @_codes[code] =
        type: type
        data: data
    trigger: (code) ->
      if @_codes[code]?
        type = @_codes[code].type
        data = @_codes[code].data
        if @_callbacks[type]?
          cbs = @_callbacks[type]
          if cbs.length
            cb = cbs[cbs.length-1]
            cb(data, code)

  $(document).on 'keypress', (e) ->

    keycode = if e.which then e.which else e.keyCode

    if keycode >= 65 and keycode <= 90 or keycode >= 97 and keycode <= 122 or keycode >= 48 and keycode <= 57
      chars.push String.fromCharCode keycode
    else if keycode is 13
      if chars.length >= 10
        Barcode.trigger chars.join('')
      chars = []
    do update

  update = _.debounce ->
    chars = []
  , 50

  window.Barcode = Barcode

  Vue.directive 'barcode',
    bind: (el, binding, vnode) ->
      for mod of binding.modifiers
        Barcode.on mod, binding.value
    unbind: (el, binding, vnode) ->
      for mod of binding.modifiers
        Barcode.off mod, binding.value
