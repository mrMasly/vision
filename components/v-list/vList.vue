<template lang="jade">
ul.v-list(:class='[themeClass]')
  slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-list'
  mixins: [theme]

return component
</script>
