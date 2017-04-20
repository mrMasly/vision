<template lang="jade">
.toolbar.l-row.l-fill.l-start-center(ref="toolbar")
  input.l-flex(placeholder="Добавить задачу"
  v-model="task.title"
  @keydown.enter="save")

  md-button.md-icon-button.md-primary(@click.native="$refs.panel.open")
    md-icon settings

  md-button.md-icon-button.md-primary(@click.native="save")
    md-icon check

  v-panel(ref="panel" align="toolbar" x="end" y="after" alive)
    Settings.settings(@close="$refs.panel.close()", :task="task", @save="save")

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
  padding 0 0 0 8px
input
  font-size 16px
  border none
  outline none
  box-shadow none
.md-speed-dial
  position relative
  top 5px
</style>
