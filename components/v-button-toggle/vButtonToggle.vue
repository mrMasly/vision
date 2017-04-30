<template lang="jade">
.v-button-toggle(:class='[themeClass]')
  slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'

onClickButton = null

component =
  name: 'v-button-toggle'
  props:
    single: Boolean
  mixins: [ theme ]
  mounted: ->
    _this = this
    @$children.forEach (child) ->
      element = child.$el
      toggleClass = 'v-toggle'

      onClickButton = ->
        if _this.single
          _this.$children.forEach (child) ->
            child.$el.classList.remove toggleClass

          element.classList.add toggleClass
        else
          element.classList.toggle toggleClass


      if element and element.classList.contains('v-button')
        element.addEventListener 'click', onClickButton

  beforeDestroy: ->
    @$children.forEach (child) ->
      element = child.$el
      if element and element.classList.contains('v-button')
        element.removeEventListener 'click', onClickButton


return component
</script>

<style lang="stylus" scoped>
</style>
