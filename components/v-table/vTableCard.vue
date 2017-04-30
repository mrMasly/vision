<template lang="jade">
v-card.v-table-card(:class='[themeClass]')
  slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-table-card'
  mixins: [theme]

return component
</script>
