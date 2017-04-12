<template lang="jade">
.l-column
  .toolbar.md-transparent.md-whiteframe-1dp
    Add.l-flex
</template>

<script lang="coffee">
import Add from '../add/Add.vue'
component =
  name: 'tasks-data'
  components: { Add }

return component
</script>

<style lang="stylus" scoped>
.toolbar
  padding 0 8px
  height 48px
</style>
