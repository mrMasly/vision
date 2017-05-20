import Vue from 'vue'

Vue.directive 'barcode',
  bind: (el, binding, vnode) ->
    if binding.arg
      Barcode.on binding.arg, binding.value
  unbind: (el, binding, vnode) ->
    if binding.arg
      Barcode.off binding.arg, binding.value
