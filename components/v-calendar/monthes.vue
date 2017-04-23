<template lang="jade">
.l-row.l-wrap.container(:style="style")
    Month.month(v-for="month in monthes", :key="month"
    @select="select" @selectPeriod="selectPeriod",
    :selected="selected",
    :date="month")
</template>

<script lang="coffee">
import _ from 'lodash'
import Month from './month.vue'
component =
  name: 'monthes'
  components: { Month }
  data: ->
    monthes: []
    rows: 1
    columns: 1
    style: {}
  props: [ 'date', 'period', 'selected', 'value' ]
  computed:
    getMonthes: -> _.chunk @monthes, @rows
  created: ->
    do @update
  watch:
    value: -> do @check
    date: -> do @update
  methods:
    check: ->

      min = moment(@monthes[0]).startOf('month').format('YYYY-MM-DD')
      max = moment(@monthes[@monthes.length-1]).endOf('month').format('YYYY-MM-DD')
      if @period
        date1 = moment(@value[0]).format('YYYY-MM-DD')
        date2 = moment(@value[1]).format('YYYY-MM-DD')
        unless min <= date1 <= max
          return @$emit 'getDate'
        unless min <= date2 <= max
          return @$emit 'getDate'
      else
        date = moment(@value).format('YYYY-MM-DD')
        @$emit 'getDate' unless min <= date <= max

    update: ->
      if @$layout.width >= 900 then @rows = 3;
      else if @$layout.width >= 650 then @rows = 2
      else @rows = 1
      if @$layout.height >= 700 then @columns = 2
      else @columns = 1
      amount = @columns * @rows

      @style.width = (@rows * 260)+'px'
      @style.height = (@column * 294)+'px'

      date = moment(@date).subtract(amount-1, 'month')

      @monthes = []
      for i in [0...amount]
        @monthes.push date.add(1, 'month').format('YYYY-MM-DD')


    select: (day) ->
      if @period
        unless @selected[0]?
          selected = [day, day]
        else if @selected[0] >= day
          selected = [day, day]
        else if @selected[0] is @selected[1]
          selected = [@selected[0], day]
        else
          selected = [day, day]
      else
        selected = day
      @$emit 'select', selected
    selectPeriod: (min, max) ->
      if @period
        @$emit 'select', [min, max]

return component
</script>

<style lang="stylus" scoped>
.month
  margin 8px
.month-button
  min-width 40px
  width 40px
  padding 0
</style>
