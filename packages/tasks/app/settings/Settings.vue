<template lang="jade">
main.md-whiteframe-2dp.l-padding
  Dates(:task="task")
  md-divider
  Priority(:task="task")
  md-divider
  Users(:task="task")
  //- Tags(:task="task")
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
    display: yes
  methods:
    close: -> @$emit 'close'
    save: ->
      @task.date = moment(@date+' '+@time).toDate()
return component
</script>

<style lang="stylus" scoped>
main
  width 310px
  height auto
.md-divider
  margin 8px 0
</style>
