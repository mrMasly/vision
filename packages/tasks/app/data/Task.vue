<template lang="jade">

//- .l-row.l-relative.task.l-start-center.has-ripple(@click="open"
  @contextmenu.prevent="settings")
.l-row.l-relative.task.l-start-center.has-ripple(@click="open")
  v-ripple
  Done(:task="task")
  Priority(:task="task")
  Users(:task="task")
  .title.l-flex {{task.title}}
  .time(:style="{color: time.color}") {{time.text}}

</template>

<script lang="coffee">
import Settings from '../settings/Settings.vue'
import Priority from '../helpers/Priority.vue'
import Done from '../helpers/Done.vue'
import Users from '../helpers/Users.vue'
component =
  name: 'task'
  components: { Settings, Priority, Done, Users }
  props:
    task: Object
  created: ->
  computed:
    time: ->
      text = require('../fromnow.coffee')(@task.date, no, no)
      if text is 'Сегодня' and @task.time
        text = moment(@task.date).format('HH:mm')
      if moment(@task.date).format('X') < moment().format('X')
        color = 'rgba(210, 0, 0, 0.67)'
      else
        color = 'rgba(0, 0, 0, 0.8)'
      return { color, text }
  methods:
    open: ->
      @$router.push params: { id: @task._id }
    settings: (e) ->
      @$parent.$parent.$parent.settings @task, e

return component
</script>

<style lang="stylus" scoped>

h = 34px

.task
  cursor pointer
  height h
  padding 2px 10px
  overflow hidden
  &:hover
    background-color rgba(0, 0, 0, 0.05)
.link
  cursor pointer
  position relative
  height 100%
.time
  font-size .75em
.title
  overflow hidden
  white-space nowrap
  text-overflow ellipsis
.time
  margin-left 10px
  white-space nowrap
  text-align right
</style>
