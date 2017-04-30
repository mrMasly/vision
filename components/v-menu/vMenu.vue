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
    vSize:
      type: [Number, String]
      default: 0
    vDirection:
      type: String
      default: 'bottom right'
    vAlignTrigger:
      type: Boolean
      default: false
    vOffsetX:
      type: [Number, String]
      default: 0
    vOffsetY:
      type: [Number, String]
      default: 0
    vCloseOnSelect:
      type: Boolean
      default: true
  data: ->
    active: false
  watch:
    vSize: (current, previous) ->
      if current >= 1 and current <= 7
        @removeLastSizeMenuContentClass previous
        @addNewSizeMenuContentClass current
    vDirection: (current, previous) ->
      @removeLastDirectionMenuContentClass previous
      @addNewDirectionMenuContentClass current
    vAlignTrigger: (trigger) ->
      @handleAlignTriggerClass trigger
  methods:
    validateMenu: ->
      if !@menuContent
        @$destroy()
        throw new Error('You must have a v-menu-content inside your menu.')
      if !@menuTrigger
        @$destroy()
        throw new Error('You must have an element with a v-menu-trigger attribute inside your menu.')
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
      top += parseInt(@vOffsetY, 10)
      left += parseInt(@vOffsetX, 10)
      if @vAlignTrigger
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
      if !@vDirection
        position = @getPosition('bottom', 'right')
      else
        position = @getPosition.apply(this, @vDirection.trim().split(' '))
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
      _this = this

      close = (event) ->
        if _this.menuContent and event.target == _this.menuContent
          activeRipple = _this.menuContent.querySelector('.v-ripple.v-active')
          _this.menuContent.removeEventListener transitionEndEventName, close
          _this.menuTrigger.focus()
          _this.active = false
          if activeRipple
            activeRipple.classList.remove 'v-active'
          document.body.removeChild _this.menuContent
          document.body.removeChild _this.backdropElement
          window.removeEventListener 'resize', _this.recalculateOnResize

      @menuContent.addEventListener transitionEndEventName, close
      @menuContent.classList.remove 'v-active'
      @$emit 'close'
    toggle: ->
      if @active then @close()
      else @open()
  mounted: ->
    @$nextTick ->
      @menuTrigger = @$el.querySelector('[v-menu-trigger]')
      @menuContent = @$el.querySelector('.v-menu-content')
      @backdropElement = @$refs.backdrop.$el
      @validateMenu()
      @handleAlignTriggerClass @vAlignTrigger
      @addNewSizeMenuContentClass @vSize
      @addNewDirectionMenuContentClass @vDirection
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
