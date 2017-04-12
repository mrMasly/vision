<template lang="jade">
main.md-whiteframe-2dp.l-padding
  Dates(:task="task")
  Priority(:task="task")
  Users(:task="task")
  .l-row.actions
    md-button.l-50.md-raised(@click.native="close") Отмена
    md-button.l-50.md-raised(@click.native="save") Сохранить
</template>

<script lang="coffee">
import Dates from './Dates.vue'
import Priority from './Priority.vue'
import Users from './Users.vue'
import Tags from './Tags.vue'
component =
  name: 'settings'
  components: { Dates, Priority, Users, Tags }
  data: ->
    task:
      date: moment().toDate()
      priority: 1
      users: [Meteor.userId()]
      tags: []
      repeat:
        date:
          start: null
          end: null
        toggle: no
        week: []
        month:
          type: 'month'
          index: 'first'
          weekDay: 0
          monthDays: []
    display: yes
  methods:
    close: -> @$emit 'close'
    save: ->
      @task.date = moment(@date+' '+@time).toDate()
return component
</script>

<style lang="stylus" scoped>
main
  width 300px
  height auto
.md-divider
  margin 8px 0
</style>
