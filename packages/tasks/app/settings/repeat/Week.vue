<template lang="jade">
.l-row
  md-button.md-primary.l-flex(
  v-for="(day, index) in days"
  @click.native="add(index)",
  :class="[{'md-raised': (task.repeat.week.indexOf(index)+1)}]")
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
.md-button
  width auto
  min-width 30px
  margin 2px
  padding 0
</style>
