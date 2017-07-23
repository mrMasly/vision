<template lang="jade">
.day.l-column(@mouseover="hover=true" @mouseleave="hover=false" ref="day")
  v-caption {{date | moment("D MMMM")}}
  v-icon.showAll(v-if="hover" @click.native="showAll") open_in_new
  .l-flex.tasks
    .task(v-for="task in data", :class="{done: task.done}" @click="open(task)")
      v-tooltip {{task.title}}
      .priority(v-if="task.priority != 1")
        span(v-if="task.priority == 3" style="color:#f00") !!!
        span(v-else-if="task.priority == 2" style="color:rgb(228, 185, 0)") !!
        span(v-else-if="task.priority == 0" style="color:#0f0") !
      .time(v-if="task.time") {{task.date | moment('HH:mm')}}
      .title {{task.title}}
    .task(v-if="data.length < tasks.length" @click="showAll") + еще {{tasks.length - data.length}}
  v-button.v-fab.v-fab-bottom-right.v-mini(v-show="hover" @click.native="add")
    v-icon add
  v-panel(ref="panel" align="day" x="start" y="end")
    Add(:params="{date: date}" focus @keydown.native.esc="$refs.panel.close()"
    @save="$refs.panel.close()")
</template>

<script lang="coffee">
import _ from 'lodash'
import Add from '../../add/Add.vue'
component =
  name: 'Day'
  components: { Add }
  props:
    date: Date
    size: Number
  data: ->
    hover: no
  methods:
    add: ->
      @$refs.panel.open()
    open: (task) ->
      @$router.push params: id: task._id
    showAll: ->
      @$emit 'open', @date
  meteor:
    tasks: ->
      Mongo.Tasks.find
        date:
          $gte: moment(@date).startOf('day').toDate()
          $lte: moment(@date).endOf('day').toDate()
        for: Meteor.userId()
      ,
        fields: title: 1, time: 1, date: 1, priority: 1, done: 1
        sort: priority: -1, time: -1, date: 1
  computed:
    data: ->
      return null unless @tasks
      return @tasks[0...@size]

return component
</script>

<style lang="stylus" scoped>
.day
  width 100%
  height 100%
  oveflow hidden
  position absolute
  top 0
  user-select none
.showAll
  font-size 14px
  color rgba(0,0,0,.54)
  cursor pointer
  margin 0
  position absolute
  top 2px
  right -2px
.v-fab
  right 3px
  bottom 3px
  height 30px !important
  width 30px !important
  min-height 30px !important
  min-width 30px !important
  line-height 30px !important
.tasks
  overflow hidden
.task
  font-size 12px
  line-height 12px
  height 14px
  padding 2px
  width 100%
  width calc(100% - 2px)
  overflow hidden
  text-overflow ellipsis
  white-space nowrap
  cursor pointer
  transition background-color .2s
  &.done
    text-decoration line-through
  &:hover
    background-color rgba(0,0,0,.1)
.priority
  display inline-block
  margin-right 2px
.time
  display inline-block
  margin-right 2px
  color rgba(0,0,0,.54)
  font-size .9em
.title
  display inline-block
</style>