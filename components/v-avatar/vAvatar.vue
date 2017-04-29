<template lang="jade">
.v-avatar(:class='[themeClass]')
  slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js';
component =
  name: 'v-avatar'
  mixins: [theme]


return component
</script>

<style lang="stylus" scoped>
</style>
