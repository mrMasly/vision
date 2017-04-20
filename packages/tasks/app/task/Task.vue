<template lang="jade">
main.l-fill(@keydown.meta="keydown")
  .task(v-if="$subReady.task")
    Toolbar(:task="task" @close="close")
    Heading(:task="task")
    Subs(:task="task")
  .loading.l-fill.l-row.l-center-center(v-else)
    md-spinner(md-indeterminate)

  md-speed-dial.md-fab-bottom-right(md-open="hover" md-direction="top")
    md-button.md-fab(md-fab-trigger @click.native="save")
      md-tooltip(md-direction="left") Сохранить (ctrl+s)
      md-icon(md-icon-morph) save
      md-icon menu
    md-button.md-fab(@click.native="remove")
      md-tooltip(md-direction="left") Удалить (ctrl+d)
      md-icon delete_forever
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
      update: (id) -> Mongo.Tasks.findOne @id

return component
</script>

<style lang="stylus" scoped>
main
  width 350px
  max-width 100%
</style>
