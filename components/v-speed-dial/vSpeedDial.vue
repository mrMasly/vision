<template lang="jade">
.v-speed-dial(:class='[themeClass, classes]')
  slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-speed-dial'
  props:
    open:
      type: String
      default: 'click'
    mode:
      type: String
      default: 'fling'
    direction:
      type: String
      default: 'top'
  mixins: [ theme ]
  data: ->
    fabTrigger: null
    active: false
  computed: classes: ->
    classes = 'v-active': @active
    classes['v-mode-' + @mode] = true
    classes['v-direction-' + @direction] = true
    classes
  watch:
    active: (val) -> @$emit 'trigger', val
  methods:
    on: -> @active = yes
    off: -> @active = no
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
      @fabTrigger = @$el.querySelector('[fab-trigger]')
      if @open == 'click'
        @fabTrigger.addEventListener 'click', @toggleSpeedDial
      else
        @$el.addEventListener 'mouseenter', @on
        @$el.addEventListener 'mouseleave', @off
  beforeDestroy: ->
    @fabTrigger.removeEventListener 'click', @toggleSpeedDial
    document.body.removeEventListener 'click', @closeSpeedDial

return component
</script>
