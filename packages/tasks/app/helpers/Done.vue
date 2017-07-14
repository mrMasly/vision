<template lang="jade">
.done
  v-checkbox(v-model="done" v-if="type == 'checkbox'" @change="change")
  v-checkbox(v-model="done" v-else-if="done" disabled)
  v-icon(v-else-if="type == 'subs'") list
  v-icon(v-else-if="type == 'delegate'") people
  v-icon(v-else-if="type == 'repeat'") autorenew
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'Done'
  props:
    task: Object
  data: ->
    done: @task.done
  watch:
    'task.done': (@done) ->
  methods:
    change: (val) ->
      Mongo.Tasks.update @task._id, $set: done: val
  computed:
    type: ->
      if @task.repeat.toggle then return 'repeat'
      else if not _.isEmpty @task.subs then return 'subs'
      else if not _.isEmpty @task.users then return 'delegate'
      else return 'checkbox'

return component
</script>

<style lang="stylus" scoped>
.done
  width 24px
  height 24px
  margin-right 4px
.v-checkbox
  margin 2px
</style>