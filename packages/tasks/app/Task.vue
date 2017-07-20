<template lang="jade">
.task.l-fill.l-relative
  v-loading(:value="$subReady.task && task")
    Edit(v-model="task" @save="save" @close="close", remove-on-meta, save-on-meta)
</template>

<script lang="coffee">
import Edit from './edit/Edit.vue'
component =
  name: 'Task'
  components: { Edit }
  props:
    id: String
  methods:
    save: -> @$emit 'save'
    close: -> @$emit 'close'
  meteor:
    server:
      publish:
        task: (id) -> Mongo.Tasks.find _id: id
    subscribe:
      task: -> [@id]
    task:
      params: -> @id
      update: (id) -> Mongo.Tasks.findOne id

return component
</script>

<style lang="stylus" scoped>
.task
  max-width 100%
  width 350px
</style>