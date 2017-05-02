<template lang="jade">
.v-sidenav(:class='[themeClass, classes]', @keyup.esc='close', tabindex='0')
  .v-sidenav-content
    slot
  v-backdrop.v-sidenav-backdrop(@close='close', ref='backdrop')
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-sidenav'
  data: ->
    visible: no
  mixins: [ theme ]
  props:
    swipeable: Boolean
    swipeThreshold:
      type: Number
      default: 15
    swipeDistance:
      type: Number
      default: 100
    left: Boolean
    right: Boolean
    fixed: Boolean
    block: Boolean
  created: ->
    # @left = yes if not @left and not @right
  computed:
    classes: ->
      'v-active': @visible
      'v-left': not @right
      'v-right': @right
      'v-fixed': @fixed
      'v-block': @block
  methods:
    show: -> @open()
    open: ->
      @visible = true
      @$el.focus()
      @$emit 'open'
    close: ->
      @visible = false
      @$el.blur()
      @$emit 'close'
    toggle: ->
      if @visible then @close()
      else @open()
    isHorizontallyInside: (positionX) ->
      positionX > 0 and positionX < @mountedRect.left + @mountedRect.width
    isVerticallyInside: (positionY) ->
      positionY > 0 and positionY < @mountedRect.top + @mountedRect.height
    isFromStartWhenClosed: (positionX) ->
      return true if @visible
      positionX < @swipeThreshold
    handleTouchStart: (event) ->
      positionX = event.touches[0].clientX - (@mountedRect.left)
      positionY = event.touches[0].clientY - (@mountedRect.top)
      if !@isHorizontallyInside(positionX) or !@isVerticallyInside(positionY) or !@isFromStartWhenClosed(positionX)
        return
      @initialTouchPosition = positionX
      @canMove = true
    handleTouchEnd: ->
      @canMove = false
      @initialTouchPosition = null
    handleTouchMove: (event) ->
      if !@canMove
        return
      positionX = event.touches[0].clientX
      difference = if @visible then @initialTouchPosition - positionX else positionX - (@initialTouchPosition)
      action = if @visible then 'close' else 'open'
      if difference > @swipeDistance
        @[action]()
  mounted: ->
    return unless @swipeable
    @mountedRect = @$refs.backdrop.$el.getBoundingClientRect()
    @initialTouchPosition = null
    @canMove = false
    document.addEventListener 'touchstart', @handleTouchStart
    document.addEventListener 'touchend', @handleTouchEnd
    document.addEventListener 'touchmove', @handleTouchMove
  beforeDestroy: ->
    return unless @swipeable
    document.removeEventListener 'touchstart', @handleTouchStart
    document.removeEventListener 'touchend', @handleTouchEnd
    document.removeEventListener 'touchmove', @handleTouchMove

return component
</script>
