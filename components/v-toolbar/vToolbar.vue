<template lang="jade">
.v-toolbar(:class='[themeClass]')
  slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js';
component =
  name: 'v-toolbar'
  mixins: [theme]

return component
</script>

<style lang="stylus" scoped>
</style>
