<template lang="jade">
main.l-fill(@keydown.meta="keydown")
  .task(v-if="$subReady.task && task")
    Toolbar(:task="task" @close="close")
    Heading(:task="task")
    Subs(:task="task")
  .loading.l-fill.l-row.l-center-center(v-else)
    v-spinner(v-indeterminate)

  v-speed-dial.v-fab-bottom-right(v-open="hover" v-direction="top")
    v-button.v-fab(v-fab-trigger @click.native="save")
      v-tooltip(v-direction="left") Сохранить (ctrl+s)
      v-icon(v-icon-morph) save
      v-icon menu
    v-button.v-fab(@click.native="remove")
      v-tooltip(v-direction="left") Удалить (ctrl+d)
      v-icon delete_forever
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
    ddd: yes
  props:
    id: String
  mounted: ->
    setTimeout =>
      @ddd = no
    , 5000
  methods:
    close: -> @$emit 'close'
    keydown: (e) ->
      if e.code is 'KeyS'
        do @save; do e.preventDefault
      else if e.code is 'KeyD'
        do @remove; do e.preventDefault
    save: (e) ->
      Mongo.Tasks.update @task._id, $set:
        title: @task.title
        description: @task.description
        subs: @task.subs
    remove: (e) ->
      @$confirm
        title: 'Удалить задачу?'
        content: @task.title
      , =>
        Mongo.Tasks.remove @task._id
        do @close

  meteor:
    server:
      publish:
        task: (id) -> Mongo.Tasks.find id
    subscribe:
      task: -> [@id]
    task:
      params: -> @id
      update: (id) ->
        task = Mongo.Tasks.findOne @id
        return task

return component
</script>

<style lang="stylus" scoped>
main
  width 350px
  max-width 100%
</style>
