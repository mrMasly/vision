<template lang="jade">
transition(name='v-spinner', appear='')
  .v-spinner(:class='[themeClass, classes]', :style='styles')
    svg.v-spinner-draw(viewbox='25 25 50 50')
      circle.v-spinner-path(cx='50', cy='50', r='20', :stroke-width='stroke', :stroke-dasharray='dashProgress')
</template>

<script lang="coffee">

import theme from '../../theme/mixin.js'

component =
  name: 'v-spinner'
  props:
    size:
      type: Number
      default: 50
    stroke:
      type: Number
      default: 3.5
    indeterminate: Boolean
    progress:
      type: Number
      default: 0
  mixins: [ theme ]
  computed:
    classes: ->
      'v-indeterminate': @indeterminate
    styles: ->
      newSize = @size + 'px'

      width: newSize
      height: newSize
    dashProgress: ->
      progress = @progress * 125 / 100
      if @indeterminate
        return false
      if progress >= 125
        progress = 130
      progress + ', 200'

return component
</script>
