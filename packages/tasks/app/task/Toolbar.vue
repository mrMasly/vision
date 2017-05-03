<template lang="jade">
.toolbar.l-row.l-start-center.v-shadow(ref="toolbar")
  v-checkbox(v-model="task.done")
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


return component
</script>

<style lang="stylus" scoped>
.v-checkbox
  margin-left 14px
.toolbar
  height 48px
  padding-right 0
  overflow hidden
</style>
