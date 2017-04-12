<template lang="jade">
.toolbar.l-row.l-fill.l-start-center
  input.l-flex(placeholder="Добавить задачу"
  v-model="task.title"
  @keydown.enter="save")

  md-menu(md-size="5" ref="menu")
    md-button.md-icon-button.md-primary(md-menu-trigger)
      md-icon settings
    md-menu-content
      Settings.settings(@close="$refs.menu.close()", :task="task")

  md-button.md-icon-button.md-primary(@click.native="save")
    md-icon check

</template>

<script lang="coffee">
import Settings from '../settings/Settings.vue'
component =
  name: 'add'
  components: { Settings }
  created: ->
    @_task = _.clone @task
  data: ->
    _task: null
    task:
      title: ''
      date: moment().toDate()
      priority: 1
      users: [Meteor.userId()]
      tags: []
      repeat:
        type: 'week'
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
    save: ->
      Mongo.Tasks.insert @task, (err, res) =>
        @task = _.clone @_task

return component
</script>

<style lang="stylus" scoped>
.toolbar
  height 48px
  padding-right 0
input
  height 100%
  font-size 16px
  border none
  outline none
  box-shadow none
.md-speed-dial
  position relative
  top 5px
</style>
