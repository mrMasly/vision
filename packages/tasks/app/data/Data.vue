<template lang="jade">
.l-relative(v-if="mounted")
  Doned.l-absolute.l-fill(v-if="$route.params.tab == 'done'")
  Month.l-absolute.l-fill(v-else-if="$route.params.tab == 'month'")
  .l-column.l-absolute.l-fill(v-else)
    .toolbar.v-transparent.v-shadow-1.l-row.l-start-center
      slot(name="sidenav-toggle")
      Add.l-flex
    .v-content.l-flex.l-column
      Options.options
      Groups.l-flex.l-scroll.groups(:groups="groups")

  v-panel(ref="panel")
    div context

</template>

<script lang="coffee">
import Add from '../add/Add.vue'
import Options from './Options.vue'
import getGroups from './group.coffee'
import Doned from './Doned.vue'
import Month from './month/Month.vue'
component =
  name: 'data-tasks'
  components: { Add, Options, Doned, Month }
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
.groups
  padding-bottom 20px
</style>
