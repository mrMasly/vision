<template lang="jade">
i.v-icon(:class='[themeClass]', v-html='svgContent', v-if='svgContent')
v-image.v-icon(:class='[themeClass]', :v-src='imageSrc', v-else-if='imageSrc')
i.v-icon(:class='[themeClass, vIconset]', :aria-hidden='!!vIconset', v-else)
  slot

</template>

<script lang="coffee">
import theme from '../../theme/mixin.js';

registeredIcons = {}
component =
  props:
    vSrc: String
    vIconset:
      type: String
      default: 'material-icons'
  data: ->
    svgContent: null
    imageSrc: null
  mixins: [ theme ]
  watch: vSrc: ->
    @svgContent = null
    @imageSrc = null
    @checkSrc()
    return
  methods:
    isImage: (mimetype) ->
      mimetype.indexOf('image') >= 0
    isSVG: (mimetype) ->
      mimetype.indexOf('svg') >= 0
    setSVGContent: (value) ->
      _this = this
      @svgContent = value
      @$nextTick ->
        _this.$el.children[0].removeAttribute 'fill'
        return
      return
    loadSVG: ->
      if !registeredIcons[@vSrc]
        request = new XMLHttpRequest
        self = this
        request.open 'GET', @vSrc, true

        request.onload = ->
          mimetype = @getResponseHeader('content-type')
          if @status >= 200 and @status < 400 and self.isImage(mimetype)
            if self.isSVG(mimetype)
              registeredIcons[self.vSrc] = @response
              self.setSVGContent @response
            else
              self.loadImage()
          else
            console.warn 'The file ' + self.vSrc + ' is not a valid image.'
          return

        request.send()
      else
        @setSVGContent registeredIcons[@vSrc]
      return
    loadImage: ->
      @imageSrc = @vSrc
      return
    checkSrc: ->
      if @vSrc
        if @vSrc.indexOf('.svg') >= 0
          @loadSVG()
        else
          @loadImage()
      return
  mounted: ->
    @checkSrc()
    return
return component
</script>
