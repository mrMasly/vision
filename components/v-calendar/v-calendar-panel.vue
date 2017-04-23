<template lang="jade">
.v-calendar-panel
  .inputs.l-row.l-start-center(ref="inputs")
    template(v-if="!period")
      input(type="date" v-model="selected")
    template(v-else)
      span.span c
      input(type="date" v-model="selected[0]")
      span.span по
      input(type="date" v-model="selected[1]")

  .l-row.l-center
    md-button.md-primary(@click.native="subYear")
      md-icon fast_rewind
    md-button.md-primary(@click.native="subMonth")
      md-icon chevron_left
    md-button.md-primary(@click.native="addMonth")
      md-icon chevron_right
    md-button.md-primary(@click.native="addYear")
      md-icon fast_forward
  Monthes(:date="date" @select="select", :period="period", :selected="selected", :value="value", @getDate="getDate")

  slot.switch(name="period")



</template>

<script lang="coffee">
import _ from 'lodash'
import Monthes from './monthes.vue'
component =
  name: 'v-calendar-panel'
  components: { Monthes }
  data: ->
    date: null
    selected: null
  created: ->
    if _.isArray @value
      @selected = [
        moment(@value[0]).format('YYYY-MM-DD')
        moment(@value[1]).format('YYYY-MM-DD')
      ]
    else
      @selected = moment(@value).format('YYYY-MM-DD')
    do @getDate

  props: ['value', 'period']
  watch:
    selected: ->
      if @period
        value = [
          if @selected[0] then moment(@selected[0]).toDate() else null
          if @selected[1] then moment(@selected[1]).toDate() else null
        ]
      else
        value = if @selected then moment(@selected).toDate() else null
      @$emit 'change', value
    period: ->
      if @period and not _.isArray @selected
        @selected ?= moment().format('YYYY-MM-DD')
        @selected = [@selected, @selected]
      else if !@period and _.isArray @selected
        if @selected[0]? then @selected = @selected[0]
        else if @selected[1]? then @selected = @selected[1]
        else @selected = moment().format('YYYY-MM-DD')
  methods:
    subYear:  -> @date = moment(@date).subtract(1, 'year').format('YYYY-MM-DD')
    subMonth: -> @date = moment(@date).subtract(1, 'month').format('YYYY-MM-DD')
    addYear:  -> @date = moment(@date).add(1, 'year').format('YYYY-MM-DD')
    addMonth: -> @date = moment(@date).add(1, 'month').format('YYYY-MM-DD')
    select: (@selected) ->
    getDate: ->
      if _.isArray @value
        if @value[1] then value = @value[1]
        else if @value[0] then value = @value[0]
        else value = moment().toDate()
      else
        value = if @value then @value else moment().toDate()
      @date = value

return component
</script>

<style lang="stylus" scoped>
.month
  margin 8px
.month-button
  min-width 40px
  width 40px
  padding 0
  &:first-child
    > .md-icon
      position absolute
      bottom 10px
      left 10px
  &:last-child
    > .md-icon
      position absolute
      top 10px
      left 10px
input
  // width 125px
  text-align center
  font-size 16px
  word-spacing 12px !important
  border none
  outline none
  box-shadow none
  &::-webkit-inner-spin-button
  &::-webkit-calendar-picker-indicator
    display none
    -webkit-appearance none
.inputs
  margin-top 18px
.switch
  position absolute
  top 10px
  right 10px
.span
  display inline-block
  margin-left 16px
</style>
