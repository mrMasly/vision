<template lang="jade">

.l-row.l-relative.task.l-start-center.has-ripple(@click="open"
  @contextmenu.prevent="settings")
  v-checkbox(v-model="task.done")
  v-ripple
  Priority(:task="task")
  .title.l-flex {{task.title}}
  .time(:style="{color: time.color}") {{time.text}}

</template>

<script lang="coffee">
import Settings from '../settings/Settings.vue'
import Priority from '../helpers/Priority.vue'
component =
  name: 'task'
  components: { Settings, Priority }
  data: ->
    time: { color: null, text: null }
  props:
    task: Object
  created: ->
    do @getTime
  watch:
    'task.date': -> do @getTime
  methods:
    getTime: ->
      if @task.date?
        date = if @task.done then @task.doneAt else @task.date
        diff = moment().endOf('day').diff(moment(date).endOf('day'), 'day')
        if @task.repeat?.toggle
          @time.color = "#636363"
          @time.text = 'повторяется'
        else if diff is 0 # сегодня
          @time.color = "rgba(0, 0, 0, 0.46)"
          if @task.time? and not @task.done
            # console.log moment().diff(@task.date, 'minute')
            if moment().diff(date, 'minute') > 0
              @time.color = 'rgba(210, 0, 0, 0.67)'
            @time.text = moment(date).format 'HH:mm'
          else
            @time.text = 'сегодня'
        else if diff is 1
          @time.color = "rgba(210, 0, 0, 0.67)"
          @time.text = 'вчера'
        else if diff > 1
          @time.color = "rgba(210, 0, 0, 0.67)"
          @time.text = moment(date).format 'D MMM'
        else if diff is -1
          @time.color = "rgba(0, 130, 64, 0.62)"
          @time.text = 'завтра'
        else if diff < -1
          @time.color = "rgba(0, 130, 64, 0.62)"
          @time.text = moment(date).format 'D MMM'

        if @task.done
          text = if @time.text is 'Сегодня' then '' else @time.text
          @time.text = text+" "+moment(@task.doneAt).format 'HH:mm'
    done: ->
      console.log 'done'
    open: ->
      @$router.push params: { id: @task._id }
    settings: (e) ->
      @$parent.$parent.$parent.settings @task, e

return component
</script>

<style lang="stylus" scoped>

h = 30px

.task
  cursor pointer
  height h
  padding 0 10px
  overflow hidden
  &:hover
    background-color rgba(0, 0, 0, 0.05)
.link
  cursor pointer
  position relative
  height 100%
.v-checkbox
  margin 2px 8px
.time
  font-size .75em
.done
  position absolute
  top 0
  left 0
  height 100%
  background-color #000
  min-width 40px
  width 45px
  margin 0
.title
  overflow hidden
  white-space nowrap
  text-overflow ellipsis
.time
  margin-left 10px
  white-space nowrap
  text-align right
</style>
