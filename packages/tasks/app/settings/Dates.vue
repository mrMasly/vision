<template lang="jade">
div
  .l-row
    md-button.md-icon-button(v-for="button in buttons"
    @click.native="select(button.name)",
    :class="[{'md-primary': (button.name == selected)}]")
      md-icon {{button.icon}}
      md-tooltip {{button.name}}
  .date
    input(v-if="chose" type="date" v-model="date" @change="change")
    div(v-else-if="selected==='Входящие'") Входящие
    div(v-else-if="selected==='Когда-нибудь'") Когда-нибудь
    div(v-else) {{selected}}, {{date | moment('D MMM YYYY')}}
  .time(v-if="needTime")
    input(type="time")


</template>

<script lang="coffee">
# import Repeat from './repeat/Repeat.vue'

component =
  name: 'dates'
  # components: { Repeat }
  props:
    task: Object
  created: ->
    do @change
  computed:
    needTime: ->
      if @selected in ['Входящие', 'Когда-нибудь']
        @time = null
        return no
      return yes
  methods:
    select: (name) ->
      if name is 'Выбрать'
        @date = moment().format('YYYY-MM-DD')
        @repeat = no
        @chose = yes
      else if name is 'Повторять'
        @repeat = yes
        @chose = no
      else
        @repeat = no
        @chose = no
        if name is 'Входящие' then @date = null
        else if name is 'Сегодня' then @date = moment().format("YYYY-MM-DD")
        else if name is 'Завтра' then @date = moment().add(1, 'day').format("YYYY-MM-DD")
        else if name is 'Через неделю' then @date = moment().add(7, 'day').format("YYYY-MM-DD")
        else if name is 'Когда-нибудь' then @date = moment(Date.MAX).format('YYYY-MM-DD')
      do @change
    change: ->
      @task.date = moment(@date).toDate()
      if @chose then @selected = 'Выбрать'; return
      if @repeat then @selected = 'Повторять'; return
      # если совпадает дата с датой, указанной в кнопке
      for button in @buttons
        if button.date is @date
          @selected = button.name
          return
      @selected = 'Выбрать'

  data: ->
    date: moment(@task.date).format('YYYY-MM-DD')
    time: moment(@task.date).format('HH:mm')
    chose: no
    selected: null
    repeat: no
    buttons: [
      {name: 'Входящие', icon: 'inbox', date: null}
      {name: 'Сегодня', icon: 'today', date: moment().format('YYYY-MM-DD')}
      {name: 'Завтра', icon: 'filter_1', date: moment().add(1, 'day').format('YYYY-MM-DD')}
      {name: 'Через неделю', icon: 'filter_7', date: moment().add(7, 'day').format('YYYY-MM-DD')}
      {name: 'Когда-нибудь', icon: 'cloud', date: moment(Date.MAX).format('YYYY-MM-DD')}
      {name: 'Выбрать', icon: 'date_range'}
      {name: 'Повторять', icon: 'autorenew'}
    ]
return component
</script>

<style lang="stylus" scoped>
.md-button
  margin 1px
.date
.time
  text-align center
  margin 8px
  height 32px
  & > div
    padding-top 5px
input
  text-align center
  font-size 14px
  width 100%
  display block
  border solid 1px #aaa
  border-radius 4px
  padding 4px
  box-shadow none
  outline none
.actions
  .md-button
    margin 8px
</style>
