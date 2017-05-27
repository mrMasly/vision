<template lang="jade">
div.v-calendar(ref="calendar" @click="open")

  template(v-if="value == null")
    .v-calendar-value
  template(v-else-if="period")
    .v-calendar-value(v-if="value[0] || value[1]")
      span(v-if="value[0]") с {{value[0] | moment('D MMM YYYY')}}&nbsp;
      span(v-if="value[1]") по {{value[1] | moment('D MMM YYYY')}}
    .v-calendar-value(v-else) Всегда
  template(v-else)
    .v-calendar-value
      span(v-if="value") {{value | moment('D MMM YYYY')}}

  .v-calendar-fill

  v-panel(ref="panel" align="calendar" x="start" y="start" alive v-if="display")
    v-calendar-panel(:value="value", :period="period" @change="change" ref="cPanel")
      //- .switch(slot="period")
      //-   v-switch(v-model="switchPeriod") Период
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
    display: no
  props:
    period:
      default: no
      type: Boolean
    value: [Date, Array]
    label: String
  mounted: ->
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
      @initValue()
      @display = yes
  methods:
    open: ->
      @$refs.panel.open()
      @$nextTick ->
        $(@$refs.cPanel.$refs.inputs).find('input').first().focus()
    change: (value) ->
      @$emit 'input', value
      @$emit 'change', value
    initValue: ->
      if @period
        unless _.isArray @value
          value = [@value, @value]
      else if not @period
        if _.isArray @value
          value = @value[0]
      if value?
        @$emit 'input', value
        @$emit 'change', value

return component
</script>
