<template lang="jade">
v-loading(:value="$subReady.tasks" @load="resize")
  .table-container
    table
      thead
        tr
          th ПН
          th ВТ
          th СР
          th ЧТ
          th ПН
          th СБ
          th ВС
      tbody
        tr(v-for="week in weeks")
          td(v-for="day in week", :style="{height: (100/weeks.length)+'%'}")
            Subday(:date="day", :size="size" @open="open", :key="day.date")
</template>

<script lang="coffee">
import _ from 'lodash'
import Subday from './Subday.vue'
component =
  name: 'Month'
  components: { Subday }
  props:
    date: Date
  data: ->
    min: null
    max: null
    size: 0
    day: null
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
      @day = date
      @$refs.dialog.open()
  created: ->
    @resize = _.debounce @resize, 300
  computed:
    weeks: ->
      min = moment(@date).startOf('month').startOf('week').format('YYYY-MM-DD')
      max = moment(@date).endOf('month').endOf('week').format('YYYY-MM-DD')
      dates = []
      while min <= max
        dates.push moment(min).toDate()
        min = moment(min).add(1, 'day').format('YYYY-MM-DD')
      @min = moment(_.head(dates)).toDate()
      @max = moment(_.last(dates)).toDate()
      return _.chunk dates, 7
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
</style>