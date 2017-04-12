<template lang="jade">
div
  md-tabs.md-transparent(md-centered @change="change")
    md-tab(md-label="День", :md-active="task.repeat.type === 'day'")
    md-tab(md-label="Неделя", :md-active="task.repeat.type === 'week'")
      Week(:task="task")
    md-tab(md-label="Месяц", :md-active="task.repeat.type === 'month'")
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
  methods:
    change: (index) ->
      @task.repeat.type = switch index
        when 0 then 'day'
        when 1 then 'week'
        when 2 then 'month'




return component
</script>

<style lang="stylus" scoped>
.md-tab
  padding 0
.md-input-container
  margin 0 0 8px
</style>
