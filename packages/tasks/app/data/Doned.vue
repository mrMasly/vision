<template lang="jade">
.l-column
  date-toolbar(v-model="date")
  .l-flex.l-relative
    .l-fill.l-absolute
      v-loading(:value="$subReady.tasks && tasks")
        .l-scroll.list
          Task(v-for="task in tasks", :task="task", :key="task._id")
</template>

<script lang="coffee">
import Task from './Task.vue'
component =
  name: 'Doned'
  components: { Task }
  data: ->
    date: new Date
  meteor:
    server:
      publish:
        tasks: (date) ->
          Mongo.Tasks.find
            done: yes
            doneAt:
              $gte: moment(date).startOf('day').toDate()
              $lte: moment(date).endOf('day').toDate()
    subscribe:
      tasks: -> [@date]
    tasks:
      params: -> @date
      update: (date) -> Mongo.Tasks.find
        done: yes
        doneAt:
          $gte: moment(date).startOf('day').toDate()
          $lte: moment(date).endOf('day').toDate()
      ,
        sort: doneAt: -1

return component
</script>

<style lang="stylus" scoped>
.list
  padding-top 18px
</style>