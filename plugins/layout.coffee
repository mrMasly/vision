import Vue from 'vue'

$layout = {}
resize = ->
  if Meteor.isClient
    width = window.innerWidth
    height = window.innerHeight
  else
    width = 1280
    height = 720
  $layout.width = width
  $layout.height = height
  $layout.xs = width < 600
  $layout.sm = 600 <= width < 960
  $layout.md = 960 <= width < 1280
  $layout.lg = 1280 <= width < 1620
  $layout.xl = 1920 <= width
  $layout.gxs = width >= 600
  $layout.gsm = width >= 960
  $layout.gmd = width >= 1280
  $layout.glg = width >= 1620
if Meteor.isClient
  window.addEventListener 'resize', resize
do resize

Plugin = {}

Plugin.install = (vue, options) ->
  Vue.prototype.$layout = $layout

  vue.mixin
    data: ->
      $layout: $layout

Vue.use Plugin
