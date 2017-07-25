<template lang="jade">
v-tabs.v-transparent(centered @change="change")
  v-tab(label="Дни месяца", :active="task.repeat.month.type === 'month'")
    .l-column(style="padding-top:8px")
      .l-row.l-start(v-for="one in month")
        v-button.v-primary(v-for="day in one",
          :class="[{'l-flex': (day=='last'), 'v-raised': task.repeat.month.monthDays.indexOf(day)+1}]"
          @click.native="addMonthDay(day)")
          span(v-if="day=='last'") Последний
          span(v-else) {{day}}
  v-tab(label="Дни недели", :active="task.repeat.month.type === 'week'")
    .l-row.l-space-between
      v-input-container.l-45
        label Каждый
        v-select(v-model="task.repeat.month.index" multiple)
          v-option(v-for="(rus, name) in weekIndexes", :value="name") {{rus}}
      v-input-container.l-50
        v-select(v-model="task.repeat.month.weekDay" multiple)
          v-option(v-for="(name, index) in weekDays", :value="index") {{name}}
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'month'
  props:
    task: Object
  data: ->
    month: [1..31]
    weekIndexes:
      first: 'Первый'
      second: 'Второй'
      third: 'Третий'
      fourth: 'Четверный'
      last: 'Последний'
    weekDays: [
      'Понедельник'
      'Вторник'
      'Среду'
      'Четверг'
      'Пятницу'
      'Субботу'
      'Воскресенье'
    ]
  created: ->
    @month.push 'last'
    @month = _.chunk @month, 7
  methods:
    addMonthDay: (day) ->
      if day in @task.repeat.month.monthDays
        @task.repeat.month.monthDays = _.without @task.repeat.month.monthDays, day
      else
        @task.repeat.month.monthDays.push day
      @task.repeat.month.monthDays = _.sortBy @task.repeat.month.monthDays, (i) -> i
    change: (index) ->
      @task.repeat.month.type = switch index
        when 0 then 'month'
        when 1 then 'week'

return component
</script>

<style lang="stylus" scoped>
.v-button
  width 40px
  min-width 30px
  margin 2px
  padding 0
  min-height 26px
  line-height 26px
  height 26px
.v-tab
  padding 0
.last
  flex-grow 999
</style>
