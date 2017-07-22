<template lang="jade">
.l-column

  template(v-if="today")
    v-button.v-mini(@click.native="setStart") Начало: cегодня
  v-input-container(v-else)
    label Начало
    v-input(type="date" v-model="date.start" ref="start" @change="change")

  template(v-if="date.end==null")
    v-button.v-mini(@click.native="setEnd") Повторять: Всегда
  v-input-container(v-else)
    label Повторять до
    v-input(type="date" v-model="date.end" ref="end" @change="change")

  template(v-if="date.time==null")
    v-button.v-mini(@click.native="setTime") Указать время
  v-input-container(v-else)
    label Время
    v-input(type="time" v-model="date.time" ref="time" @change="change")

</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'dates'
  props:
    task: Object
  data: ->
    date: @task.repeat.date
    today: moment().format('YYYY-MM-DD') is @task.repeat.date.start
  methods:
    change: ->
      setTimeout =>
        if _.isEmpty @date.start
          @date.start = moment().format('YYYY-MM-DD')
          @today = yes
        if _.isEmpty @date.end
          @date.end = null
        if _.isEmpty @date.time
          @date.time = null
      , 100
    setStart: ->
      @date.start = moment().format('YYYY-MM-DD')
      @today = no
      @$nextTick -> @$refs.start.$el.select()
    setEnd: ->
      @date.end = moment().format('YYYY-MM-DD')
      @$nextTick -> @$refs.end.$el.select()
    setTime: ->
      @date.time = "09:00"
      @$nextTick -> @$refs.time.$el.select()
return component
</script>

<style lang="stylus" scoped>
.v-input-container
  margin-bottom 0
.v-button
  margin-bottom 0 !important
</style>
