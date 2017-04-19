<template lang="jade">
.md-panel(v-show="isOpen")
  template(v-if="alive")
    .backdrop(@click="close" v-show="isOpen")
    .md-panel-container.md-whiteframe-2dp(:style="style" ref="container" v-show="isOpen")
      slot
  template(v-else)
    .backdrop(@click="close" v-if="isOpen")
    .md-panel-container.md-whiteframe-2dp(:style="style" ref="container" v-if="isOpen")
      slot
</template>

<script lang="coffee">
import position from './position.coffee'
component =
  name: 'Panel'
  props: ['align', 'x', 'y', 'alive']
  data: ->
    isOpen: no
    style:
      top: 0
      left: 0
      width: 'auto'
      height: 'auto'
      opacity: 0
    interval: null
  mounted: ->
    $(@$el).appendTo 'body'
    @interval = setInterval (=> do @position), 1000
  methods:
    close: ->
      @style.opacity = 0
      setTimeout =>
        @isOpen = no
      , 200
      @$emit 'close'
    open: (e) ->
      @isOpen = yes
      @$nextTick =>
        do @position
        @style.opacity = 1
      @$emit 'open'
    position: position
  beforeDestroy: ->
    $(@$el).remove()
    clearInterval @interval
return component
</script>

<style lang="stylus" scoped>
.md-panel
  position fixed
  width 100%
  height 100%
  z-index 999
.backdrop
  position absolute
  top 0
  left 0
  width 100%
  height 100%
.md-panel-container
  position absolute
  background-color #fff
  transition opacity .2s
</style>
