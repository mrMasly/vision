<template lang="jade">
div
  Task(v-for="task in tasks", :task="task" v-if="$subReady.tasks")
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
        setTimeout (=> do @update), 100
        return Mongo.Tasks.find match
return component
</script>

<style lang="stylus" scoped>

</style>
