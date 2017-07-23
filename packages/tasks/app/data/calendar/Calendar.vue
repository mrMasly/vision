<template lang="jade">
.l-column
  date-toolbar(:type="$store.state.vision.tasks.calendar.type"
    v-model="$store.state.vision.tasks.calendar.date")
    div(slot="left")
      slot
    v-button.v-icon-button(slot="right" @click.native="change")
      v-icon date_range
      v-tooltip {{changeTitle}}
  .l-flex.l-relative
    component(:is="$store.state.vision.tasks.calendar.type",
      :date="$store.state.vision.tasks.calendar.date")
</template>

<script lang="coffee">
import _ from 'lodash'
import Day from './Day.vue'
import Week from './Week.vue'
import Month from './Month.vue'
component =
  name: 'Calendar'
  components: { Day, Week, Month }
  methods:
    change: ->
      @$store.state.vision.tasks.calendar.type = switch @$store.state.vision.tasks.calendar.type
        when 'day' then 'week'
        when 'week' then 'month'
        else 'day'
  computed:
    changeTitle: ->
      'Переключить на ' + switch @$store.state.vision.tasks.calendar.type
        when 'day' then 'неделю'
        when 'week' then 'месяц'
        else 'день'
  


return component
</script>

<style lang="stylus" scoped>
</style>