<template lang="jade">
i.v-icon(:class='[themeClass]', v-html='svgContent', v-if='svgContent')
v-image.v-icon(:class='[themeClass]', :v-src='imageSrc', v-else-if='imageSrc')
i.v-icon(:class='[themeClass, iconset]', :aria-hidden='!!iconset', v-else)
  slot

</template>

<script lang="coffee">
import theme from '../../theme/mixin.js';

registeredIcons = {}
component =
  props:
    src: String
    iconset:
      type: String
      default: 'material-icons'
  data: ->
    svgContent: null
    imageSrc: null
  mixins: [ theme ]
  watch: src: ->
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
      if !registeredIcons[@src]
        request = new XMLHttpRequest
        self = this
        request.open 'GET', @src, true

        request.onload = ->
          mimetype = @getResponseHeader('content-type')
          if @status >= 200 and @status < 400 and self.isImage(mimetype)
            if self.isSVG(mimetype)
              registeredIcons[self.src] = @response
              self.setSVGContent @response
            else
              self.loadImage()
          else
            console.warn 'The file ' + self.src + ' is not a valid image.'
          return

        request.send()
      else
        @setSVGContent registeredIcons[@src]
      return
    loadImage: ->
      @imageSrc = @src
      return
    checkSrc: ->
      if @src
        if @src.indexOf('.svg') >= 0
          @loadSVG()
        else
          @loadImage()
      return
  mounted: ->
    @checkSrc()
    return
return component
</script>
