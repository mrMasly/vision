<template lang="jade">
.toolbar.l-row.l-start-center.v-shadow(ref="toolbar")
  v-checkbox(v-model="task.done")
  .priority(v-if="task.priority != 1", :style="{color: priorityColor}") {{priority}}
  .l-flex
  v-button.v-icon-button.v-primary(@click.native="$refs.panel.open")
    v-icon settings

  v-button.v-icon-button.v-primary(@click.native="close")
    v-icon close

  v-panel(ref="panel" align="toolbar" x="end" y="after" alive)
    Settings.settings(@close="$refs.panel.close()", :task="task")
</template>

<script lang="coffee">
import Settings from '../settings/Settings.vue'
component =
  name: 'toolbar'
  components: { Settings }
  props:
    task: Object
  methods:
    close: -> @$emit 'close'
  computed:
    priority: ->
      switch @task.priority
        when 0 then '!'
        when 2 then '!!'
        when 3 then '!!!'
    priorityColor: ->
      switch @task.priority
        when 0 then '#0f0'
        when 2 then '#e4b900'
        when 3 then '#f00'


return component
</script>

<style lang="stylus" scoped>
.v-checkbox
  margin-left 14px
  margin-top 4px
.toolbar
  height 48px
  padding-right 0
  overflow hidden
.priority
  font-size 1.5em
  margin-right 4px
</style>
