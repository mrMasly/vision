<template lang="jade">
div
  v-tabs.v-transparent(v-centered @change="change")
    v-tab(v-label="День", :active="task.repeat.type === 'day'")
    v-tab(v-label="Неделя", :active="task.repeat.type === 'week'")
      Week(:task="task")
    v-tab(v-label="Месяц", :active="task.repeat.type === 'month'")
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
.v-tab
  padding 0
.v-input-container
  margin 0 0 8px
</style>
