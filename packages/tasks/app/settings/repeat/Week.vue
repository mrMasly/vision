<template lang="jade">
.l-row
  v-button.v-primary.l-flex(
  v-for="(day, index) in days"
  @click.native="add(index)",
  :class="[{'v-raised': (task.repeat.week.indexOf(index)+1)}]")
    | {{ day }}
</template>

<script lang="coffee">
component =
  name: 'week'
  data: ->
    days: ['ПН','ВТ','СР','ЧТ','ПТ','СБ','ВС']
  props:
    task: Object
  methods:
    add: (index) ->
      if index in @task.repeat.week
        @task.repeat.week = _.without @task.repeat.week, index
      else
        @task.repeat.week.push index
      @task.repeat.week = _.sortBy @task.repeat.week, (i)->i

return component
</script>

<style lang="stylus" scoped>
.v-button
  width auto
  min-width 30px
  margin 2px
  padding 0
</style>
