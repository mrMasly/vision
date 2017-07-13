<template lang="jade">
.l-relative(v-if="mounted")
  .l-column.l-absolute.l-fill
    .toolbar.v-transparent.v-shadow-1.l-row.l-start-center
      slot(name="sidenav-toggle")
      Add.l-flex
    .v-content.l-flex.l-column
      Options.options
      Groups.l-flex(:groups="groups")

  v-panel(ref="panel")
    Settings(@close="$refs.panel.close()", :task="task")

</template>

<script lang="coffee">
import Add from '../add/Add.vue'
import Options from './Options.vue'
import getGroups from './group.coffee'
import Settings from '../settings/Settings.vue'
component =
  name: 'data-tasks'
  components: { Add, Options, Settings }
  data: ->
    groups: []
    task: null
    mounted: no
  mounted: ->
    @mounted = yes
  created: ->
    do @update
  methods:
    update: ->
      @groups = getGroups()
    settings: (task, e) ->
      @task = task
      @$refs.panel.open e
  watch:
    '$store.state.vision.tasks.options': -> do @update
    '$store.state.vision.tasks.group': -> do @update

return component
</script>

<style lang="stylus" scoped>
.toolbar
  z-index 2
  height 48px
  min-height 48px
.options
  height 56px
  min-height 56px
</style>
