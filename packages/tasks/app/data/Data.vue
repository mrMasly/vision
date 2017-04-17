<template lang="jade">
.l-column
  .toolbar.md-transparent.md-whiteframe-1dp
    Add.l-flex
  .md-content.l-flex
</template>

<script lang="coffee">
import Add from '../add/Add.vue'
import groups from './group.coffee'
component =
  name: 'data-tasks'
  components: { Add }
  created: ->
    lists = groups()
    console.log lists
return component
</script>

<style lang="stylus" scoped>
.toolbar
  z-index 2
  padding 0 8px
  height 48px
</style>
