<template lang="jade">
div
  md-tabs.md-transparent(md-centered)
    md-tab(md-label="День")
    md-tab(md-label="Неделя")
      Week(:task="task")
    md-tab(md-label="Месяц")
      Month(:task="task")
  Dates(:task="task")



</template>

<script lang="coffee">
import Week from './Week.vue'
import Month from './Month.vue'
import Dates from './Dates.vue'
component =
  name: 'repeat'
  components: { Week, Month, Dates }
  props:
    task: Object



return component
</script>

<style lang="stylus" scoped>
.md-tab
  padding 0
.md-input-container
  margin 0 0 8px
</style>
