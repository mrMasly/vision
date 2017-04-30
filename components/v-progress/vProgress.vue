<template lang="jade">
transition(name='v-progress', appear='')
  .v-progress(:class='[themeClass, classes]')
    .v-progress-track(:style='styles')
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-progress'
  props:
    vIndeterminate: Boolean
    vProgress:
      type: Number
      default: 0
  mixins: [ theme ]
  computed:
    classes: ->
      'v-indeterminate': @vIndeterminate
    styles: ->
      if !@vIndeterminate
        return { width: @vProgress + '%' }

return component
</script>
