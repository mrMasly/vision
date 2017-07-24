<template lang="jade">
.task.l-fill.l-relative
  v-loading(:value="$subReady.task && task" v-if="id")
    Edit.edit(v-model="task" @save="save" @close="close", remove-on-meta, save-on-meta)
</template>

<script lang="coffee">
import Edit from './edit/Edit.vue'
component =
  name: 'Task'
  components: { Edit }
  data: ->
    checkTask: null
  props:
    id: String
  methods:
    save: ->
      @$emit 'save'
      do @close unless @$layout.gmd
    close: -> @$emit 'close'
    check: (task) ->
      if @checkTask? and not task?
        do @close
      else
        @checkTask = task
  watch:
    '$store.state.vision.tasks.user': (user) ->
      if @task? and @task.for isnt user
        do @close
  meteor:
    server:
      publish:
        task: (id) -> Mongo.Tasks.find _id: id
    subscribe:
      task: -> [@id]
    task:
      params: -> @id
      update: (id) ->
        task = Mongo.Tasks.findOne id
        @check task
        return task

return component
</script>

<style lang="stylus" scoped>
.task
  max-width 100%
  width 350px
.edit
  position absolute !important
</style>