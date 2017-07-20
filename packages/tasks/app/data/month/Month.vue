<template lang="jade">
.l-column
  date-toolbar(type="month" v-model="date")
  .l-flex.l-relative
    v-loading(:value="$subReady.tasks")
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
                Day(:date="day", :size="size" @open="open", :key="day.date")
  v-dialog(ref="dialog" @close="full = null")
    FullDay(:date="full" v-if="full" @close="$refs.dialog.close()")
</template>

<script lang="coffee">
import _ from 'lodash'
import Day from './Day.vue'
import FullDay from './FullDay.vue'
component =
  name: 'Month'
  components: { Day, FullDay }
  data: ->
    date: new Date()
    min: null
    max: null
    size: 0
    full: null
  mounted: ->
    $(window).on 'resize', @resize
    @$nextTick -> @resize()
  beforeDestroy: ->
    $(window).off 'resize', @resize
  methods:
    resize: ->
      td = $(@$el).find('td').first()
      height = td.height() - 30
      size = height / 16
      @size = _.floor size
    open: (date) ->
      @full = date
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
        tasks: (min, max) ->
          Mongo.Tasks.find
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
      tasks: -> [@min, @max]

  

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