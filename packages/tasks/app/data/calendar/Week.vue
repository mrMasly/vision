<template lang="jade">
.table-container
  table
    thead
      tr
        th(v-for="day in days", :key="day")
          span {{day | moment('D MMM, dd')}}
          v-icon.open(@click.native="open(day)") open_in_new
    tbody
      tr
        td.day(v-for="day in days", :key="day")
          Subday(:date="day", :size="size", :dense="false")
</template>

<script lang="coffee">
import _ from 'lodash'
import Subday from './Subday.vue'
component =
  name: 'Week'
  components: { Subday }
  props:
    date: Date
  data: ->
    min: null
    max: null
    size: 0
  mounted: ->
    $(window).on 'resize', @resize
    @$nextTick -> @resize()
  beforeDestroy: ->
    $(window).off 'resize', @resize
  methods:
    resize: ->
      td = $(@$el).find('td').first()
      unless td.length
        setTimeout (=> do @resize), 300
      else
        height = td.height() - 30
        size = height / 16
        @size = _.floor size
    open: (date) ->
      @$store.state.vision.tasks.calendar.type = 'day'
      @$store.state.vision.tasks.calendar.date = @date
  computed:
    days: ->
      @min = moment(@date).weekStart().format('YYYY-MM-DD')
      @max = moment(@date).weekEnd().format('YYYY-MM-DD')
      dates = []
      for i in [0..6]
        dates.push moment(@min).add(i, 'days').toDate()
      return dates
  meteor:
    server:
      publish:
        tasks: (min, max, user) ->
          Mongo.Tasks.find
            for: user
            date:
              $gte: moment(min).startOf('day').toDate()
              $lte: moment(max).endOf('day').toDate()
          ,
            fields:
              title: 1
              date: 1
              for: 1
              time: 1
              priority: 1
              done: 1
    subscribe:
      tasks: -> [@min, @max, @$store.state.vision.tasks.user]


return component
</script>

<style lang="stylus" scoped>
.table-container
  position absolute
  width 100%
  height 100%
  overflow-x auto
table
  min-width 100%
  min-height 100%
  border-collapse collapse
  table-layout fixed
th
  text-align center
td, th
  position relative
  border 1px solid rgba(0,0,0,0.12)
  width 14%
  &:first-child
    border-left none
  &:last-child
    border-right none
tr:last-child
  td, th
    border-bottom none
.day
  min-width 150px
.open
  font-size 16px
  color rgba(0,0,0,.54)
  cursor pointer
  position relative
  top 3px
</style>