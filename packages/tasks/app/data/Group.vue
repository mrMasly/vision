<template lang="jade">
div
  div(v-for="task in tasks") {{task.title}}
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'group'
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
    data:
      tasks: -> Mongo.Tasks.find @group.match, transform: (doc) =>
        do @update; return doc
return component
</script>

<style lang="stylus" scoped>

</style>
