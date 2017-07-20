<template lang="jade">
.full-day.l-column
  v-toolbar.l-row.l-space-between
    v-title.l-flex {{date | moment}}
    v-button.v-icon-button(@click.native="close")
      v-icon close
  v-toolbar.v-transparent.v-dense.v-shadow
    Add(:date="date")
  v-dialog-content.l-flex.content(v-if="$subReady.tasks")
    Task(v-for="task in tasks", :task="task", :key="task._id")
</template>

<script lang="coffee">
import Task from '../Task.vue'
import Add from '../../add/Add.vue'
component =
  name: 'FullDay'
  components: { Task, Add }
  props:
    date: Date
  methods:
    close: -> @$emit 'close'
  meteor:
    server:
      publish:
        tasks: (date) ->
          date =
            $gte: moment(date).startOf('day').toDate()
            $lte: moment(date).endOf('day').toDate()
          Mongo.Tasks.find $or: [
            {date: date}
            {doneAt: date}
          ]
    subscribe:
      tasks: -> [@date]
    tasks: ->
      date =
        $gte: moment(@date).startOf('day').toDate()
        $lte: moment(@date).endOf('day').toDate()
      Mongo.Tasks.find $or: [
        {date: date}
        {doneAt: date}
      ]
return component
</script>

<style lang="stylus" scoped>
.full-day
  width 500px
  max-width 100%
  height 400px
.content
  padding-top 20px !important
  padding-left 0 !important
  padding-right 0 !important
</style>