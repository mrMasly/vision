<template lang="jade">
.l-column

  div.l-column(v-if="date.start==null")
    md-button.l-flex.md-mini(@click.native="setStart") Начало: cегодня
  md-input-container(v-else)
    label Начало
    md-input(type="date" v-model="date.start" id="repeatStart" @change="change")

  div.l-column(v-if="date.end==null")
    md-button.l-flex.md-mini(@click.native="setEnd") Повторять: Всегда
  md-input-container(v-else)
    label Повторять до
    md-input(type="date" v-model="date.end" id="repeatEnd" @change="change")

</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'dates'
  props:
    task: Object
  data: ->
    date: @task.repeat.date
  methods:
    change: ->
      setTimeout =>
        @date.start = null if _.isEmpty @date.start
        @date.end = null if _.isEmpty @date.end
      , 100
    setStart: ->
      @date.start = moment().format('YYYY-MM-DD')
      $('#repeatStart').select()
    setEnd: ->
      @date.end = moment().format('YYYY-MM-DD')
      $('#repeatEnd').select()
return component
</script>

<style lang="stylus" scoped>
.md-input-container
  margin-bottom 0
</style>
