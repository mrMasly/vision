<template lang="jade">
.l-fill
  .task(v-if="$subReady.task")
    Toolbar(:task="task" @close="close")
    Heading(:task="task")
    Subs(:task="task")
  .loading.l-fill.l-row.l-center-center(v-else)
    md-spinner(md-indeterminate)

</template>

<script lang="coffee">

import Heading from './Heading.vue'
import Toolbar from './Toolbar.vue'
import Subs from './Subs.vue'
component =
  name: 'task'
  components: { Toolbar, Heading, Subs }
  data: ->
    show: yes
  props:
    id: String
  methods:
    close: -> @$emit 'close'
  meteor:
    server:
      publish:
        task: (id) -> Mongo.Tasks.find id
    subscribe:
      task: -> [@id]
    task:
      params: -> @id
      update: (id) -> Mongo.Tasks.findOne @id

return component
</script>

<style lang="stylus" scoped>
</style>
