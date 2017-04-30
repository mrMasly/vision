<template lang="jade">
img.v-image(:src="vSrc", :class="classes")
</template>

<script lang="coffee">

import getImageLightness from '../../utils/getImageLightness.js';

component =
  name: 'v-image'
  props:
    vSrc: String
  data: ->
    loaded: false
    applyBlack: true
    imageElement: null
  watch:
    vSrc: ->
      @createImage()
  computed:
    classes: ->
      'v-loaded': @loaded
      'v-black-output': @applyBlack
  methods:
    analyzeLightness: (image) ->
      _this = this

      applyLoad = ->
        _this.loaded = true
        return

      getImageLightness image, ((lightness) ->
        limit = 256
        darkness = (Math.abs(limit - lightness) * 100 / limit + 15) / 100
        if darkness >= 0.7
          _this.applyBlack = true
        _this.$nextTick applyLoad
      ), applyLoad

    createImage: ->
      @loaded = false
      @applyBlack = false
      @imageElement = null
      if @vSrc
        @imageElement = document.createElement('img')
        @imageElement.crossOrigin = ''
        @imageElement.src = @vSrc
        @analyzeLightness @imageElement

  created: ->
    @createImage()


return component
</script>
