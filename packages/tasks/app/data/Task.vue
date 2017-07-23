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
import Priority from '../helpers/Priority.vue'
import Done from '../helpers/Done.vue'
import Users from '../helpers/Users.vue'
component =
  name: 'task'
  components: { Priority, Done, Users }
  props:
    task: Object
  created: ->
  computed:
    time: ->
      color = 'rgba(0, 0, 0, 0.8)'
      text  = ''
      if @task.done
        doneAt = @task.doneAt ? new Date()
        text = moment(doneAt).format('HH:mm')
      else if @task.repeat.toggle
        text = 'Повторяющаяся'
      else if @task.date is no
        text = 'Когда-нибудь'
      else if @task.date is null
        text = 'Без даты'
      else
        text = require('../fromnow.coffee')(@task.date, no, @task.time)
        if @task.date and @task.time
          if moment(@task.date).format('X') < moment().format('X')
            color = 'rgba(210, 0, 0, 0.67)'
        else if @task.date
          if moment(@task.date).format('X') < moment().startOf('day').format('X')
            color = 'rgba(210, 0, 0, 0.67)'
      return { color, text }
  methods:
    open: ->
      @$router.push query: { task: @task._id }
    settings: (e) ->
      @$parent.$parent.$parent.settings @task, e

return component
</script>

<style lang="stylus" scoped>

h = 30px

.task
  cursor pointer
  height h
  padding 1px 10px
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
