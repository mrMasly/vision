<template lang="jade">
transition(name='v-spinner', appear='')
  .v-spinner(:class='[themeClass, classes]', :style='styles')
    svg.v-spinner-draw(viewbox='25 25 50 50')
      circle.v-spinner-path(cx='50', cy='50', r='20', :stroke-width='vStroke', :stroke-dasharray='dashProgress')
</template>

<script lang="coffee">

import theme from '../../theme/mixin.js'

component =
  name: 'v-spinner'
  props:
    vSize:
      type: Number
      default: 50
    vStroke:
      type: Number
      default: 3.5
    vIndeterminate: Boolean
    vProgress:
      type: Number
      default: 0
  mixins: [ theme ]
  computed:
    classes: ->
      'v-indeterminate': @vIndeterminate
    styles: ->
      newSize = @vSize + 'px'

      width: newSize
      height: newSize
    dashProgress: ->
      progress = @vProgress * 125 / 100
      if @vIndeterminate
        return false
      if progress >= 125
        progress = 130
      progress + ', 200'

return component
</script>
