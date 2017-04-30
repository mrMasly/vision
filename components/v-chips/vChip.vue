<template lang="jade">
.v-chip(:class='[themeClass, classes]', tabindex='0')
  slot
  v-button.v-icon-button.v-dense.v-delete(v-if='vDeletable', @click.native="!disabled && $emit('delete')", @keyup.native.delete="!disabled && $emit('delete')", tabindex='-1')
    v-icon.v-icon-delete cancel
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-chip'
  props:
    disabled: Boolean
    vDeletable: Boolean
  mixins: [ theme ]
  computed:
    classes: ->
      'v-deletable': @vDeletable
      'v-disabled': @disabled

return component
</script>
