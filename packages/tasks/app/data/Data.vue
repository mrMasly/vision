<template lang="jade">
.l-column
  md-toolbar.md-transparent.md-dense.md-whiteframe-1dp
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
// .md-toolbar
//   padding 0 10px
</style>
