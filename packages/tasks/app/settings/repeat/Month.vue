<template lang="jade">
md-tabs.md-transparent(md-centered)
  md-tab(md-label="Дни месяца")
    .l-column(style="padding-top:8px")
      .l-row.l-start(v-for="one in month")
        md-button.md-primary(v-for="day in one",
          :class="[{'l-flex': (day=='last'), 'md-raised': task.repeat.month.monthDays.indexOf(day)+1}]"
          @click.native="addMonthDay(day)")
          span(v-if="day=='last'") Последний
          span(v-else) {{day}}
  md-tab(md-label="Дни недели")
    .l-row.l-space-between
      md-input-container.l-45
        label Каждый
        md-select(v-model="task.repeat.month.index")
          md-option(v-for="(rus, name) in weekIndexes", :value="name") {{rus}}
      md-input-container.l-50
        md-select(v-model="task.repeat.month.weekDay")
          md-option(v-for="(name, index) in weekDays", :value="index") {{name}}
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

return component
</script>

<style lang="stylus" scoped>
.md-button
  width 40px
  min-width 30px
  margin 2px
  padding 0
  min-height 26px
  line-height 26px
  height 26px
.md-tab
  padding 0
.last
  flex-grow 999
</style>
