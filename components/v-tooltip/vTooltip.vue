<template lang="jade">
span.v-tooltip(:class='classes', :style='style' ref="tooltip")
  slot
</template>

<script lang="coffee">
import transitionEndEventName from '../../utils/transitionEndEventName.js'
component =
  name: 'v-tooltip'
  props:
    direction:
      type: String
      default: 'bottom'
    delay:
      type: String
      default: '0'
  data: ->
    active: false
    parentClass: null
    transitionOff: false
    topPosition: false
    leftPosition: false
  computed:
    classes: ->
      cssClasses =
        'v-active': @active
        'v-transition-off': @transitionOff
        'v-tooltip-top': @direction == 'top'
        'v-tooltip-right': @direction == 'right'
        'v-tooltip-bottom': @direction == 'bottom'
        'v-tooltip-left': @direction == 'left'
      if @parentClass
        cssClasses[@parentClass] = true
      cssClasses
    style: ->
      'transition-delay': @delay + 'ms'
      top: @topPosition + 'px'
      left: @leftPosition + 'px'
  watch:
    direction: ->
      @calculateTooltipPosition()
  methods:
    removeTooltips: ->
      if @tooltipElement.parentNode
        @tooltipElement.removeEventListener transitionEndEventName, @removeTooltips
        @tooltipElement.parentNode.removeChild @tooltipElement
    calculateTooltipPosition: ->
      position = @parentElement.getBoundingClientRect()
      cssPosition = {}
      switch @direction
        when 'top'
          cssPosition.top = position.top - (@$el.offsetHeight)
          cssPosition.left = position.left + position.width / 2
        when 'right'
          cssPosition.top = position.top
          cssPosition.left = position.left + position.width
        when 'bottom'
          cssPosition.top = position.bottom
          cssPosition.left = position.left + position.width / 2
        when 'left'
          cssPosition.top = position.top
          cssPosition.left = position.left - (@$el.offsetWidth)
        else
          console.warn 'Invalid ' + @direction + ' option to v-direction option'
      @topPosition = cssPosition.top
      @leftPosition = cssPosition.left
    generateTooltipClasses: ->
      classes = []
      [@parentElement.classList...].forEach (cssClass) ->
        if cssClass.indexOf('v-') >= 0 and cssClass != 'v-active'
          classes.push cssClass + '-tooltip'
      @parentClass = classes.join(' ')
    open: ->
      @removeTooltips()
      @$nextTick ->
        document.body.appendChild @tooltipElement
        getComputedStyle(@tooltipElement).top
        @transitionOff = true
        @generateTooltipClasses()
        @calculateTooltipPosition()
        window.setTimeout (=>
          @transitionOff = false
          @active = true
        ), 10
    close: ->
      @active = false
      @tooltipElement.removeEventListener transitionEndEventName, @removeTooltips
      @tooltipElement.addEventListener transitionEndEventName, @removeTooltips
      window.setTimeout (=>
        @active = false
      ), 20
  mounted: ->
    @$nextTick ->
      @tooltipElement = @$el
      @parentElement = @tooltipElement.parentNode
      @$el.parentNode.removeChild @$el
      @parentElement.addEventListener 'mouseenter', @open
      @parentElement.addEventListener 'focus', @open
      @parentElement.addEventListener 'mouseleave', @close
      @parentElement.addEventListener 'blur', @close
  beforeDestroy: ->
    @active = false
    @removeTooltips()
    if @parentElement
      @parentElement.removeEventListener 'mouseenter', @open
      @parentElement.removeEventListener 'focus', @open
      @parentElement.removeEventListener 'mouseleave', @close
      @parentElement.removeEventListener 'blur', @close


return component
</script>
