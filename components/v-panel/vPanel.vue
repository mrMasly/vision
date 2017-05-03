<template lang="jade">
.v-panel(v-show="isOpen")
  template(v-if="alive")
    .backdrop(@click="close" v-show="isOpen")
    .v-panel-container.v-shadow-2(ref="container" v-show="isOpen")
      slot
  template(v-else)
    .backdrop(@click="close" v-if="isOpen")
    .v-panel-container.v-shadow-2(ref="container" v-if="isOpen")
      slot
</template>

<script lang="coffee">
import position from './position.coffee'
component =
  name: 'Panel'
  props: ['align', 'x', 'y', 'alive']
  data: ->
    isOpen: no
    e: null
    style:
      top: 0
      left: 0
      width: 'auto'
      height: 'auto'
    interval: null
  mounted: ->
    # $(@$el).appendTo 'body'
    # @interval = setInterval (=> do @position), 1000
  methods:
    opacity: (val) ->
      $(@$refs.container).css opacity: val
    close: ->
      @opacity 0
      setTimeout =>
        @isOpen = no
      , 200
      @$emit 'close'
    open: (e) ->
      @isOpen = yes
      @e = e
      @$nextTick =>
        do @position
        @opacity 1
      @$emit 'open'

    position: position
  beforeDestroy: ->
    $(@$el).remove()
    clearInterval @interval
return component
</script>
