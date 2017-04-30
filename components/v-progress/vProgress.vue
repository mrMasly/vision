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
    indeterminate: Boolean
    progress:
      type: Number
      default: 0
  mixins: [ theme ]
  computed:
    classes: ->
      'v-indeterminate': @indeterminate
    styles: ->
      if !@indeterminate
        return { width: @progress + '%' }

return component
</script>
