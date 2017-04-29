<template lang="jade">
.month
  v-button.title(@click.native="selectMonth") {{date | moment('MMMM YYYY')}}
  table
    thead
      tr
        th(v-for="weekday in weekdays") {{weekday}}
    tbody
      tr(v-for="week in weeks")
        td(v-for="day in week")
          .day(v-if="day" @click="select(day)", :class="[{active: day.active}]") {{day.day}}
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'month'
  props: ['selected', 'date']
  watch:
    selected: -> do @update
  data: ->
    dates: []
    weekdays: ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс']
  computed:
    weeks: -> _.chunk @dates, 7
  created: ->
    min = moment(@date).startOf('month')
    max = moment(@date).endOf('month')
    @dates = []
    before = Number(min.format('e'))
    @dates.push null for i in [0...before]
    while min.format('YYYY-MM-DD') <= max.format('YYYY-MM-DD')
      @dates.push
        date: min.format('YYYY-MM-DD')
        day: min.format('D')
        active: no
      min.add(1, 'day')
    do @update
  methods:
    select: (day) ->
      @$emit 'select', day.date
    selectMonth: (day) ->
      min = moment(@date).startOf('month').format('YYYY-MM-DD')
      max = moment(@date).endOf('month').format('YYYY-MM-DD')
      @$emit 'selectPeriod', min, max
    update: ->
      if _.isArray @selected
        date = _.clone @selected
        date[0] = '0000-00-00' if _.isEmpty date[0]
        date[1] = '9999-99-99' if _.isEmpty date[1]
        for day in @dates
          continue unless day?
          if date[0] <= day.date <= date[1]
            day.active = yes
          else day.active = no
      else
        for day in @dates
          continue unless day?
          if @selected is day.date
            day.active = yes
          else day.active = no

return component
</script>

<style lang="stylus" scoped>
.month
  user-select none
  width 240px
  height 278px
.title
  width 100%
th
  color rgba(0, 0, 0, 0.36)
  font-size 14px
  font-weight normal
  text-transform uppercase
.day
  border-radius 50%
  width 30px
  height 30px
  line-height 30px
  text-align center
  cursor pointer
  &.active
    background-color #2196f3
    color #fff
    &:hover
      background-color #2196f3
      color #fff
  &:hover
    background-color rgba(#000000, 0.2)
    // color #fff
</style>
