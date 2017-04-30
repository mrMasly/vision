<template lang="jade">
.v-card(:class='[themeClass, classes]')
  slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-card'
  props:
    withHover: Boolean
  mixins: [ theme ]
  computed:
    classes: ->
      'v-with-hover': @withHover


return component
</script>
