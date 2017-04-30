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
    vVisible: no
  mixins: [ theme ]
  props:
    vSwipeable: Boolean
    vSwipeThreshold:
      type: Number
      default: 15
    vSwipeDistance:
      type: Number
      default: 100
  computed:
    classes: ->
      @vVisible and 'v-active'
  methods:
    show: -> @open()
    open: ->
      @vVisible = true
      @$el.focus()
      @$emit 'open'
    close: ->
      @vVisible = false
      @$el.blur()
      @$emit 'close'
    toggle: ->
      if @vVisible then @close()
      else @open()
    isHorizontallyInside: (positionX) ->
      positionX > 0 and positionX < @mountedRect.left + @mountedRect.width
    isVerticallyInside: (positionY) ->
      positionY > 0 and positionY < @mountedRect.top + @mountedRect.height
    isFromStartWhenClosed: (positionX) ->
      return true if @vVisible
      positionX < @vSwipeThreshold
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
      difference = if @vVisible then @initialTouchPosition - positionX else positionX - (@initialTouchPosition)
      action = if @vVisible then 'close' else 'open'
      if difference > @vSwipeDistance
        @[action]()
  mounted: ->
    if !@vSwipeable
      return
    @mountedRect = @$refs.backdrop.$el.getBoundingClientRect()
    @initialTouchPosition = null
    @canMove = false
    document.addEventListener 'touchstart', @handleTouchStart
    document.addEventListener 'touchend', @handleTouchEnd
    document.addEventListener 'touchmove', @handleTouchMove
  beforeDestroy: ->
    if !@vSwipeable
      return
    document.removeEventListener 'touchstart', @handleTouchStart
    document.removeEventListener 'touchend', @handleTouchEnd
    document.removeEventListener 'touchmove', @handleTouchMove

return component
</script>
