<template lang="jade">
div.v-calendar(ref="calendar" @click="open")

  template(v-if="period2")
    .v-calendar-value(v-if="value[0] || value[1]")
      span(v-if="value[0]") с {{value[0] | moment('D MMM YYYY')}}&nbsp;
      span(v-if="value[1]") по {{value[1] | moment('D MMM YYYY')}}
    .v-calendar-value(v-else) Всегда
  template(v-else)
    .v-calendar-value
      span(v-if="value") {{value | moment('D MMM YYYY')}}

  .v-calendar-fill

  v-panel(ref="panel" align="calendar" x="start" y="start" alive v-if="display")
    v-calendar-panel(:value="value", :period="period2" @change="change" ref="cPanel")
      .switch(slot="period")
        v-switch(v-model="period2") Период
</template>

<script lang="coffee">
import _ from 'lodash'
import vCalendarPanel from './vCalendarPanel.vue'
import getClosestVueParent from '../../../utils/getClosestVueParent.js'
import common from '../common.js'
component =
  name: 'v-calendar'
  components: { vCalendarPanel }
  mixins: [ common ]
  data: ->
    period2: !!@period
    display: no
  props:
    period:
      default: no
    value: [Date, Array]
    label: String
  created: ->
    unless @value?
      value = moment().toDate()
      value = [value, value] if @period
      @$emit 'input', value
      @$emit 'change', value
    else if @period and not _.isArray @value
      value = [@value, @value]
      @$emit 'input', value
      @$emit 'change', value
  mounted: ->
    @display = yes
    @$nextTick ->
      @parentContainer = getClosestVueParent(@$parent, 'v-input-container')
      if !@parentContainer
        @$destroy()
        throw new Error('You should wrap the v-calendar in a v-input-container')
      @setParentDisabled()
      @setParentRequired()
      @setParentPlaceholder()
      @handleMaxLength()
      @updateValues()
  methods:
    open: ->
      @$refs.panel.open()
      @$nextTick ->
        $(@$refs.cPanel.$refs.inputs).find('input').first().focus()
    change: (value) ->
      @$emit 'input', value
      @$emit 'change', value
  computed:
    labelClass: ->
      if @period then 'v-caption'
      else if @value? then 'v-caption'
      else 'v-placeholder'
return component
</script>
