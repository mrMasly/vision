<template lang="jade">
.v-speed-dial(:class='[themeClass, classes]')
  slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-speed-dial'
  props:
    vOpen:
      type: String
      default: 'click'
    vMode:
      type: String
      default: 'fling'
    vDirection:
      type: String
      default: 'top'
  mixins: [ theme ]
  data: ->
    fabTrigger: null
    active: false
  computed: classes: ->
    classes = 'v-active': @active
    classes['v-mode-' + @vMode] = true
    classes['v-direction-' + @vDirection] = true
    classes
  methods:
    closeSpeedDial: (event) ->
      if !event.target == @fabTrigger or !@fabTrigger.contains(event.target)
        @active = false
        document.body.removeEventListener 'click', @closeSpeedDial
    toggleSpeedDial: ->
      @active = !@active
      setTimeout =>
        document.body.addEventListener 'click', @closeSpeedDial
      , 50
  mounted: ->
    @$nextTick ->
      @fabTrigger = @$el.querySelector('[v-fab-trigger]')
      if @vOpen == 'click'
        @fabTrigger.addEventListener 'click', @toggleSpeedDial
      else
        @$el.addEventListener 'mouseenter', @toggleSpeedDial
        @$el.addEventListener 'mouseleave', @toggleSpeedDial
  beforeDestroy: ->
    @fabTrigger.removeEventListener 'click', @toggleSpeedDial
    document.body.removeEventListener 'click', @closeSpeedDial

return component
</script>
