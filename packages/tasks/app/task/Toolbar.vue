<template lang="jade">
.toolbar.l-row.l-start-center.md-whiteframe-1dp
  md-checkbox(v-model="task.done")
  .l-flex
  md-menu(md-size="5" ref="menu")
    md-button.md-icon-button.md-primary(md-menu-trigger)
      md-icon settings
    md-menu-content
      Settings.settings(@close="$refs.menu.close()", :task="task")
  md-button.md-icon-button.md-primary(@click.native="close")
    md-icon close
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
