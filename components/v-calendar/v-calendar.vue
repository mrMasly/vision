<template lang="jade">
div.v-calendar(ref="calendar" @click="open" v-if="display")
  .v-calendar-label(:class="[labelClass]") {{label}}
  template(v-if="period2")
    .v-calendar-value(v-if="value[0] || value[1]")
      span(v-if="value[0]") с {{value[0] | moment('D MMM YYYY')}}&nbsp;
      span(v-if="value[1]") по {{value[1] | moment('D MMM YYYY')}}
    .v-calendar-value(v-else) Всегда
  template(v-else)
    .v-calendar-value {{value | moment('D MMM YYYY')}}
  v-panel(ref="panel" align="calendar" x="start" y="start" alive)
    v-calendar-panel(:value="value", :period="period2" @change="change" ref="cPanel")
      .switch(slot="period")
        md-switch(v-model="period2") Период
</template>

<script lang="coffee">
import _ from 'lodash'
import vCalendarPanel from './v-calendar-panel.vue'
component =
  name: 'v-calendar'
  components: { vCalendarPanel }
  data: ->
    period2: !!@period
    display: no
  props:
    period:
      default: no
    value: [Date, Array]
    label: String
  created: ->
    if @period and not _.isArray @value
      value = [@value, @value]
      @$emit 'input', value
      @$emit 'change', value
      @$nextTick ->
        @display = yes
    else
      @display = yes
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
      if @period then 'md-caption'
      else if @value? then 'md-caption'
      else 'md-placeholder'
return component
</script>

<style lang="stylus" scoped>
.v-calendar
  cursor pointer
  width 100%
  position relative
  height auto
  box-sizing border-box
  padding-top 20px
  margin 8px 0
.v-calendar-value
  white-space nowrap
  width 100%
  position relative
  min-height 25px
  line-height 20px
  font-size 16px
  border-bottom solid 1px rgba(0, 0, 0, .15)
  box-sizing border-box

  &:hover
    &:after
      color rgba(0, 0, 0, .54)
  &:after
    color rgba(0, 0, 0, .38)
    margin-top 2px
    position absolute
    top 50%
    right 0
    transform translateY(-50%) scaleY(.45) scaleX(.85)
    transition all .15s linear
    content "\25BC"
    box-sizing inherit
.v-calendar-label
  position absolute
  &.md-placeholder
    top 20px
    font-size 16px
    color rgba(0,0,0,.54)
  &.md-caption
    top 0px

</style>
