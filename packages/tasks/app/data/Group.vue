<template lang="jade">
transition-group(name="list")
  Task(v-for="task in tasks", :task="task" v-if="$subReady.tasks", :key="task._id")
</template>

<script lang="coffee">
import _ from 'lodash'
import Task from './Task.vue'
component =
  name: 'group'
  components: { Task }
  props:
    group: Object
  created: ->
    @update = _.debounce @update, 300
  methods:
    update: ->
      @group.size = if @tasks then @tasks.length else 0
  meteor:
    server:
      publish:
        tasks: (match) -> Mongo.Tasks.find match
    subscribe:
      tasks: -> [@group.match]
    tasks:
      params: -> @group.match
      update: (match) ->
        do @update
        return Mongo.Tasks.find match,
          fields:
            description: 0
          sort:
            doneAt: 1
            priority: -1
            time: -1
            date: 1
return component
</script>

<style lang="stylus" scoped>
.list-enter-active
.list-leave-active
  transition all .5s
.list-enter,
.list-leave-to
  opacity 0
.list-move
  transition transform .5s
</style>
