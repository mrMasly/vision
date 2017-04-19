<template lang="jade">
.l-relative
  .l-column.l-absolute.l-fill
    .toolbar.md-transparent.md-whiteframe-1dp
      Add.l-flex
    .md-content.l-flex.l-column
      Options
      Groups.l-flex(:groups="groups")
</template>

<script lang="coffee">
import Add from '../add/Add.vue'
import Options from './Options.vue'
import getGroups from './group.coffee'
component =
  name: 'data-tasks'
  components: { Add, Options }
  data: ->
    groups: []
  created: ->
    do @update
  methods:
    update: ->
      @groups = getGroups()
  watch:
    '$store.state.vision.tasks.options': -> do @update
    '$store.state.vision.tasks.group': -> do @update

return component
</script>

<style lang="stylus" scoped>
.toolbar
  z-index 2
  // padding 0 8px
  height 48px
</style>
