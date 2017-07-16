<template lang="jade">
.l-column

  div.l-column(v-if="date.start==null")
    v-button.l-flex.v-mini(@click.native="setStart") Начало: cегодня
  v-input-container(v-else)
    label Начало
    v-input(type="date" v-model="date.start" id="repeatStart" @change="change")

  div.l-column(v-if="date.end==null")
    v-button.l-flex.v-mini(@click.native="setEnd") Повторять: Всегда
  v-input-container(v-else)
    label Повторять до
    v-input(type="date" v-model="date.end" id="repeatEnd" @change="change")

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
.v-input-container
  margin-bottom 0
</style>
