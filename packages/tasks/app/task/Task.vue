<template lang="jade">
main.l-relative(@keydown.meta="keydown")
  v-loading(:value="$subReady.task && task")
    .task
      Toolbar(:task="task" @close="close")
      .saving(style="height:4px")
        v-progress(indeterminate v-if="saving")
      Heading(:task="task" @save="save")
      Subs(:task="task" @save="save")

  v-button.v-fab.v-fab-bottom-right.v-mini(@click.native="remove")
    v-tooltip(direction="left") Удалить (ctrl+d)
    v-icon delete_forever
  
</template>

<script lang="coffee">
import _ from 'lodash'
import Heading from './Heading.vue'
import Toolbar from './Toolbar.vue'
import Subs from './Subs.vue'
component =
  name: 'task'
  components: { Toolbar, Heading, Subs }
  data: ->
    show: yes
    ddd: yes
    mounted: no
    status: null
    saving: no
  props:
    id: String
  mounted: ->
    @mounted = yes
    setTimeout =>
      @ddd = no
    , 5000
  created: ->
    @save = _.debounce @save, 1000
  methods:
    close: -> @$emit 'close'
    keydown: (e) ->
      if e.code is 'KeyS'
        do @save; do e.preventDefault
      else if e.code is 'KeyD'
        do @remove; do e.preventDefault
    save: (e) ->
      @saving = yes
      # @status = 'saving'
      Mongo.Tasks.update @task._id, $set:
        title: @task.title
        description: @task.description
        subs: @task.subs
      , (err, res) =>
        if err then @toast 'Ошибка при сохранении задачи'
        else @saving = no
          # setTimeout (=> @status = null), 1000
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
  height 100%
.saving
  z-index 999
  top 0
  background-color rgba(255,255,255,.5)
</style>
