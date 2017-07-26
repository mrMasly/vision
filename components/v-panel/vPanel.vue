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
import _ from 'lodash'

component =
  name: 'Panel'
  props: ['align', 'x', 'y', 'alive']
  data: ->
    isOpen: no
    e: null
    element: null
    style:
      top: 0
      left: 0
      width: 'auto'
      height: 'auto'
    interval: null
  mounted: ->
    @$nextTick ->
      @element = @$el
      do @removeElement
  methods:
    removeElement: ->
      if document.body.contains(@element)
        @$el.parentNode.removeChild @$el
    opacity: (val) ->
      $(@$refs.container).css opacity: val
    close: ->
      $(document).off 'keydown', @keydown
      @opacity 0
      setTimeout =>
        @isOpen = no
        do @removeElement
      , 200
      @$emit 'close'
    open: (e) ->
      console.log 'open'
      $(document).on 'keydown', @keydown
      document.body.appendChild @element
      @isOpen = yes
      @e = e
      @$nextTick =>
        do @position
        @opacity 1
      @$emit 'open'
    keydown: _.debounce (e) ->
      if e.keyCode is 27
        do e.preventDefault
        do e.stopPropagation
        do @close
        return
    , 50


    position: position
  beforeDestroy: ->
    $(@$el).remove()
    clearInterval @interval
return component
</script>
