<template lang="jade">
.toolbar.l-row.l-start-center.md-whiteframe-1dp(ref="toolbar")
  md-checkbox(v-model="task.done")
  .l-flex
  md-button.md-icon-button.md-primary(@click.native="$refs.panel.open")
    md-icon settings

  md-button.md-icon-button.md-primary(@click.native="close")
    md-icon close

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
.md-checkbox
  margin-left 14px
.toolbar
  height 48px
  padding-right 0
  overflow hidden
</style>
