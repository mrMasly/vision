<template lang="jade">
.toolbar.l-row.l-start-center.v-shadow(ref="toolbar")
  Done(:task="task")
  Priority(:task="task")
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
import Priority from '../helpers/Priority.vue'
import Done from '../helpers/Done.vue'
component =
  name: 'toolbar'
  components: { Settings, Priority, Done }
  props:
    task: Object
  methods:
    close: -> @$emit 'close'


return component
</script>

<style lang="stylus" scoped>
.done
  margin-left 12px
  margin-right 12px
.toolbar
  height 48px
  padding-right 0
  overflow hidden
.priority
  font-size 1.5em
</style>
