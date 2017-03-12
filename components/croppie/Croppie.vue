<template lang="jade">
div.layout-fill(v-bind:class="{ hidden: !display }" ref="div")
  img(v-bind:src="src" ref="img")
</template>

<script lang="coffee">

import Croppie from 'croppie'
import _ from 'lodash'

dataURLtoFile = (dataurl, filename) ->
  arr = dataurl.split(',')
  mime = arr[0].match(/:(.*?);/)[1]
  bstr = atob(arr[1])
  n = bstr.length
  u8arr = new Uint8Array(n)
  while n--
    u8arr[n] = bstr.charCodeAt(n)
  new File([ u8arr ], filename, type: mime)

component =
  module: module
  name: 'croppie'
  mounted: ->
    if @file
      @name ?= @file.name
      fr = new FileReader()
      fr.readAsDataURL @file
      fr.onload = =>
        @src = fr.result
        setTimeout @start, 300
    else
      setTimeout @start, 300

    if /\.jpe?g/.test @name
      @format = 'jpeg'
    else if /\.png/.test @name
      @format = 'png'

  data: ->
    name: null
    display: no
    src: null
    format: 'png'
  props:
    img: String
    file: File
    type:
      type: String
      default: 'square' # circle
  methods:
    get: (cb) ->
      @crop.result({type: 'base64', format: @format, circle: no}).then (data) =>
        file = dataURLtoFile data, @name
        cb file
    start: ->
      w = $(@$refs.div).width()
      h = $(@$refs.div).height()
      min = if w < h then w else h
      size = min * 0.7
      size = _.round size, -1
      @crop = new Croppie @$refs.img,
        viewport:
          width: size
          height: size
          type: @type
      setTimeout =>
        @display = yes
      , 100

return component
</script>

<style lang="stylus">
.croppie-container .cr-boundary
  height calc(100% - 40px)
</style>

<style lang="stylus" scoped>
.hidden
  visibility hidden
</style>
