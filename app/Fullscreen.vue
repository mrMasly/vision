<template lang="jade">
v-button.v-icon-button(@click.native="toggle")
  v-icon fullscreen
  v-tooltip Во весь экран
</template>

<script lang="coffee">
module.access = -> yes
component =
  name: 'Fullscreen'
  nav: yes
  navIndex: 998
  methods:
    toggle: ->
      if !document.fullscreenElement and !document.mozFullScreenElement and !document.webkitFullscreenElement
        # current working methods
        if document.documentElement.requestFullscreen
          document.documentElement.requestFullscreen()
        else if document.documentElement.mozRequestFullScreen
          document.documentElement.mozRequestFullScreen()
        else if document.documentElement.webkitRequestFullscreen
          document.documentElement.webkitRequestFullscreen Element.ALLOW_KEYBOARD_INPUT
      else
        if document.cancelFullScreen
          document.cancelFullScreen()
        else if document.mozCancelFullScreen
          document.mozCancelFullScreen()
        else if document.webkitCancelFullScreen
          document.webkitCancelFullScreen()
return component
</script>

<style lang="stylus" scoped>
</style>