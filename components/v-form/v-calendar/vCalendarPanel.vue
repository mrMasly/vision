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

  .l-row.l-center.arrows
    v-button.v-primary(@click.native="subYear")
      v-icon fast_rewind
    v-button.v-primary(@click.native="subMonth")
      v-icon chevron_left
    v-button.v-primary(@click.native="addMonth")
      v-icon chevron_right
    v-button.v-primary(@click.native="addYear")
      v-icon fast_forward
  Monthes(:date="date" @select="select", :period="period", :selected="selected", :value="value", @getDate="getDate")

  //- slot.switch(name="period")



</template>

<script lang="coffee">
import _ from 'lodash'
import Monthes from './monthes.vue'
component =
  name: 'v-calendar-panel'
  components: { Monthes }
  data: ->
    date: null
    selected: do =>
      if _.isArray @value
        return [
          moment(@value[0]).format('YYYY-MM-DD')
          moment(@value[1]).format('YYYY-MM-DD')
        ]
      else
        return moment(@value).format('YYYY-MM-DD')
  created: ->
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
