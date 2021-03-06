<template lang="jade">
.v-menu
  slot
  v-backdrop.v-menu-backdrop.v-transparent.v-active(ref='backdrop', @close='close')
</template>

<script lang="coffee">
import getInViewPosition from '../../utils/getInViewPosition.js'
import transitionEndEventName from '../../utils/transitionEndEventName.js'
component =
  name: 'v-menu'
  props:
    size:
      type: [Number, String]
      default: 0
    direction:
      type: String
      default: 'bottom right'
    alignTrigger:
      type: Boolean
      default: false
    offsetX:
      type: [Number, String]
      default: 0
    offsetY:
      type: [Number, String]
      default: 0
    closeOnSelect:
      type: Boolean
      default: true
  data: ->
    active: no
    mounted: no
  watch:
    size: (current, previous) ->
      return unless @mounted
      if current >= 1 and current <= 7
        @removeLastSizeMenuContentClass previous
        @addNewSizeMenuContentClass current
    direction: (current, previous) ->
      return unless @mounted
      @removeLastDirectionMenuContentClass previous
      @addNewDirectionMenuContentClass current
    alignTrigger: (trigger) ->
      return unless @mounted
      @handleAlignTriggerClass trigger
  methods:
    validateMenu: ->
      if !@menuContent
        @$destroy()
        throw new Error('You must have a v-menu-content inside your menu.')
      if !@menuTrigger
        @$destroy()
        throw new Error('You must have an element with a menu-trigger attribute inside your menu.')
    removeLastSizeMenuContentClass: (size) ->
      @menuContent.classList.remove 'v-size-' + size
    removeLastDirectionMenuContentClass: (direction) ->
      @menuContent.classList.remove 'v-direction-' + direction.replace(RegExp(' ', 'g'), '-')
    addNewSizeMenuContentClass: (size) ->
      @menuContent.classList.add 'v-size-' + size
    addNewDirectionMenuContentClass: (direction) ->
      @menuContent.classList.add 'v-direction-' + direction.replace(RegExp(' ', 'g'), '-')
    handleAlignTriggerClass: (trigger) ->
      if trigger
        @menuContent.classList.add 'v-align-trigger'
    getPosition: (vertical, horizontal) ->
      menuTriggerRect = @menuTrigger.getBoundingClientRect()
      top = if vertical == 'top' then menuTriggerRect.top + menuTriggerRect.height - (@menuContent.offsetHeight) else menuTriggerRect.top
      left = if horizontal == 'left' then menuTriggerRect.left - (@menuContent.offsetWidth) + menuTriggerRect.width else menuTriggerRect.left
      top += parseInt(@offsetY, 10)
      left += parseInt(@offsetX, 10)
      if @alignTrigger
        if vertical == 'top'
          top -= menuTriggerRect.height + 11
        else
          top += menuTriggerRect.height + 11
      return {
        top: top
        left: left
      }
    calculateMenuContentPos: ->
      position = undefined
      if !@direction
        position = @getPosition('bottom', 'right')
      else
        position = @getPosition.apply(this, @direction.trim().split(' '))
      position = getInViewPosition(@menuContent, position)
      @menuContent.style.top = position.top + window.pageYOffset + 'px'
      @menuContent.style.left = position.left + window.pageXOffset + 'px'
    recalculateOnResize: ->
      window.requestAnimationFrame @calculateMenuContentPos
    open: ->
      if document.body.contains(@menuContent)
        document.body.removeChild @menuContent
      document.body.appendChild @menuContent
      document.body.appendChild @backdropElement
      window.addEventListener 'resize', @recalculateOnResize
      @calculateMenuContentPos()
      getComputedStyle(@menuContent).top
      @menuContent.classList.add 'v-active'
      @menuContent.focus()
      @active = true
      @$emit 'open'
    close: ->
      close = (event) =>
        if @menuContent and event.target == @menuContent
          activeRipple = @menuContent.querySelector('.v-ripple.v-active')
          @menuContent.removeEventListener transitionEndEventName, close
          @menuTrigger.focus()
          @active = false
          if activeRipple
            activeRipple.classList.remove 'v-active'
          document.body.removeChild @menuContent
          document.body.removeChild @backdropElement
          window.removeEventListener 'resize', @recalculateOnResize

      @menuContent.addEventListener transitionEndEventName, close
      @menuContent.classList.remove 'v-active'
      @$emit 'close'
    toggle: ->
      if @active then @close()
      else @open()
  mounted: ->
    @$nextTick ->
      @mounted = yes
      @menuTrigger = @$el.querySelector('[menu-trigger]')
      @menuContent = @$el.querySelector('.v-menu-content')
      @backdropElement = @$refs.backdrop.$el
      @validateMenu()
      @handleAlignTriggerClass @alignTrigger
      @addNewSizeMenuContentClass @size
      @addNewDirectionMenuContentClass @direction
      @$el.removeChild @$refs.backdrop.$el
      @menuContent.parentNode.removeChild @menuContent
      @menuTrigger.addEventListener 'click', @toggle
  beforeDestroy: ->
    if document.body.contains(@menuContent)
      document.body.removeChild @menuContent
      document.body.removeChild @backdropElement
    @menuTrigger.removeEventListener 'click', @toggle
    window.removeEventListener 'resize', @recalculateOnResize

return component
</script>
