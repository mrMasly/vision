<template lang="jade">
.v-card-media-cover(:class='classes')
  slot
  .v-card-backdrop(:style='styles', v-if='vTextScrim', ref='backdrop')
</template>

<script lang="coffee">

import getImageLightness from '../../utils/getImageLightness.js';

component =
  name: 'v-card-media-cover'
  props:
    vTextScrim: Boolean
    vSolid: Boolean
  data: ->
    backdropBg: {}
  computed:
    classes: ->
      'v-text-scrim': @vTextScrim
      'v-solid': @vSolid
    styles: ->
      background: @backdropBg
  methods:
    applyScrimColor: (darkness) ->
      if @$refs.backdrop
        @backdropBg = 'linear-gradient(to bottom, rgba(0, 0, 0, 0) 20%, rgba(0, 0, 0, ' + darkness / 2 + ') 66%, rgba(0, 0, 0, ' + darkness + ') 100%)'
    applySolidColor: (darkness) ->
      area = @$el.querySelector('.v-card-area')
      if area
        area.style.background = 'rgba(0, 0, 0, ' + darkness + ')'
  mounted: ->
    _this = this

    applyBackground = ->
      darkness = if arguments.length > 0 and arguments[0] != undefined then arguments[0] else 0.6
      if _this.vTextScrim
        _this.applyScrimColor darkness
      else if _this.vSolid
        _this.applySolidColor darkness
      return

    image = @$el.querySelector('img')
    if image and (@vTextScrim or @vSolid)
      getImageLightness image, ((lightness) ->
        limit = 256
        darkness = (Math.abs(limit - lightness) * 100 / limit + 15) / 100
        if darkness >= 0.7
          darkness = 0.7
        applyBackground darkness
      ), applyBackground


return component
</script>
