<template lang="jade">
transition(name="v-dialog")
  .v-dialog-container(:class="[{fullscreen: fullscreen}]")
    .v-dialog-backdrop(@click="close")
    .v-dialog.md-whiteframe-2dp
      slot
</template>

<script lang="coffee">
component =
  name: 'v-dialog'
  props:
    fullscreen:
      default: no
  mounted: ->
    $(document).on 'keydown', @keydown
  destroyed: ->
    $(document).off 'keydown', @keydown
  methods:
    close: ->
      @$emit 'close'
    keydown: (e) ->
      do @close if e.keyCode is 27
return component
</script>

<style lang="stylus">
.v-dialog-enter-active
.v-dialog-leave-active
  transition opacity .3s
  .v-dialog
    transition transform .2s, opacity .2s
.v-dialog-enter
.v-dialog-leave-to
  opacity 0
  .v-dialog
    transform scale(0.8)
    opacity 0
.v-dialog-container
  position fixed
  z-index 80
  width 100%
  height 100%
  top 0
  left 0
  display flex
  flex-direction row
  justify-content center
  align-items center
  align-content center
  &.fullscreen
    @media screen and (max-width: 959px)
      .v-dialog
        max-width 100% !important
        max-height 100% !important
        width 100% !important
        height 100% !important
        border-radius 0 !important
.v-dialog-backdrop
  position absolute
  background-color rgba(0, 0, 0, 0.5)
  width 100%
  height 100%
.v-dialog
  transform scale(1)
  position relative
  min-width 300px
  max-width 90%
  max-height 90%
  background-color #fff
  overflow hidden
  display flex
  flex-flow column
  outline: none
  border-radius: 2px
</style>
