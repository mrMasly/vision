<template lang="jade">
.toolbar.l-row.l-fill.l-start-center(ref="toolbar")
  input.l-flex(placeholder="Добавить задачу"
  v-model="task.title"
  @keydown.enter="save")

  v-button.v-icon-button.v-primary(@click.native="$refs.panel.open")
    v-icon settings

  v-button.v-icon-button.v-primary(@click.native="save")
    v-icon check

  v-panel(ref="panel" align="toolbar" x="end" y="after" alive v-if="task")
    Edit.settings(:actions="true", :texts="false", :fabs="false"
      @close="$refs.panel.close()", v-model="task", @save="save")
</template>

<script lang="coffee">
import _ from 'lodash'
import Edit from '../edit/Edit.vue'
component =
  name: 'add'
  components: { Edit }
  created: ->
    @_task = _.clone @task
  data: ->
    _task: null
    task:
      title: ''
      date: moment().toDate()
      time: no
      priority: 1
      users: []
      disables: []
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
.v-speed-dial
  position relative
  top 5px
</style>
