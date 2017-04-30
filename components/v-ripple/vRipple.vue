<template lang="jade">
.v-ink-ripple(v-if="mounted || !disabled")
  .v-ripple(:class="classes", :style="styles" ref="ripple")
</template>

<script lang="coffee">
doc = document ? {}
hasTouch = 'ontouchstart' of doc

getEventName = (type) ->
  if type == 'start'
    return if hasTouch then 'touchstart' else 'mousedown'
  if hasTouch then 'touchend' else 'mouseup'

addEvent = (target, type, handler) ->
  target.addEventListener getEventName(type), handler
  return

removeEvent = (target, type, handler) ->
  target.removeEventListener getEventName(type), handler
  return
component =
  props:
    disabled: Boolean
  data: ->
    mounted: false
    rippleElement: null
    parentElement: null
    parentDimensions:
      width: null
      height: null
      top: null
      left: null
    awaitingComplete: false
    hasCompleted: false
    fadeOut: false
    active: false
  computed:
    classes: ->
      'v-fadeout': @fadeOut
      'v-active': @active
    styles: ->
      width: @parentDimensions.width
      height: @parentDimensions.height
      top: @parentDimensions.top
      left: @parentDimensions.left
    # disabled: ->
    #   @disabled or !@$material.inkRipple
  watch:
    disabled: (_disabled) ->
      if !_disabled
        @init()
      else
        @destroy()
  methods:
    checkAvailablePositions: (element) ->
      availablePositions = [
        'relative'
        'absolute'
        'fixed'
      ]
      availablePositions.indexOf(getComputedStyle(element).position) > -1
    getClosestPositionedParent: (element) ->
      parent = element and element.parentNode
      if !parent or parent.tagName.toLowerCase() == 'body'
        return false
      if @checkAvailablePositions(element)
        return element
      @getClosestPositionedParent parent
    getParentSize: ->
      parent = @parentElement
      Math.round(Math.max(parent.offsetWidth, parent.offsetHeight)) + 'px'
    getClickPosition: (event) ->
      if @$refs.ripple
        rect = @parentElement.getBoundingClientRect()
        top = event.pageY
        left = event.pageX
        if event.type == 'touchstart'
          top = event.changedTouches[0].pageY
          left = event.changedTouches[0].pageX
        return {
          top: top - (rect.top) - (@$refs.ripple.offsetHeight / 2) - (doc.body.scrollTop) + 'px'
          left: left - (rect.left) - (@$refs.ripple.offsetWidth / 2) - (doc.body.scrollLeft) + 'px'
        }
      false
    setDimensions: ->
      size = @getParentSize()
      @parentDimensions.width = size
      @parentDimensions.height = size
      return
    setPositions: (event) ->
      positions = @getClickPosition(event)
      if positions
        @parentDimensions.top = positions.top
        @parentDimensions.left = positions.left
      return
    clearState: ->
      @active = false
      @fadeOut = false
      @hasCompleted = false
      @setDimensions()
      window.clearTimeout @awaitingComplete
      removeEvent doc.body, 'end', @endRipple
      return
    startRipple: (event) ->
      _this = this
      @clearState()
      @awaitingComplete = window.setTimeout((->
        _this.hasCompleted = true
        return
      ), 400)
      addEvent doc.body, 'end', @endRipple
      @$nextTick ->
        _this.setPositions event
        _this.active = true
        return
      return
    endRipple: ->
      _this2 = this
      if @hasCompleted
        @fadeOut = true
      else
        @awaitingComplete = window.setTimeout((->
          _this2.fadeOut = true
          return
        ), 200)
      removeEvent doc.body, 'end', @endRipple
      return
    registerTriggerEvent: ->
      addEvent @parentElement, 'start', @startRipple
      return
    unregisterTriggerEvent: ->
      if @parentElement
        removeEvent @parentElement, 'start', @startRipple
      return
    init: ->
      @rippleElement = @$el
      @parentElement = @getClosestPositionedParent(@$el.parentNode)
      if !@parentElement
        @$destroy()
      else
        @rippleElement.parentNode.removeChild @rippleElement
        @parentElement.appendChild @rippleElement
        @registerTriggerEvent()
        @setDimensions()
      return
    destroy: ->
      if @rippleElement and @rippleElement.parentNode
        @unregisterTriggerEvent()
        @rippleElement.parentNode.removeChild @rippleElement
      return
  mounted: ->
    _this3 = this
    window.setTimeout (->
      if !_this3.disabled
        _this3.init()
      else
        _this3.destroy()
      _this3.$nextTick ->
        _this3.mounted = true
        return
      return
    ), 100
    return
  beforeDestroy: ->
    @destroy()
    return
return component
</script>

<style lang="stylus">

swift-ease-out-duration = .4s;
swift-ease-out-timing-function = cubic-bezier(.25, .8, .25, 1);
swift-ease-out = all swift-ease-out-duration swift-ease-out-timing-function;

swift-ease-in-duration = .3s;
swift-ease-in-timing-function = cubic-bezier(.55, 0, .55, .2);
swift-ease-in = all swift-ease-in-duration swift-ease-in-timing-function;

swift-ease-in-out-duration = .5s;
swift-ease-in-out-timing-function = cubic-bezier(.35, 0, .25, 1);
swift-ease-in-out = all swift-ease-in-out-duration swift-ease-in-out-timing-function;

swift-linear-duration = .15s;
swift-linear-timing-function = linear;
swift-linear = all swift-linear-duration swift-linear-timing-function;

material-enter-duration = .3s;
material-enter-timing-function = cubic-bezier(.0, .0, .2, 1);
material-enter = all material-enter-duration material-enter-timing-function;

material-leave-duration = .3s;
material-leave-timing-function = cubic-bezier(.4, .0, 1, 1);
material-leave = all material-leave-duration $material-leave-timing-function;



</style>
