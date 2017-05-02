<template lang="jade">
div
  .l-row
    v-button.v-icon-button.l-flex(v-for="button in buttons"
    @click.native="select(button.name)",
    :class="[{'v-primary': (button.name == selected)}]")
      v-icon {{button.icon}}
      v-tooltip {{button.name}}

  Repeat(v-if="repeat", :task="task")
  .date(v-else)
    v-input-container(v-if="chose")
      v-input(type="date" v-model="date" @change="change")
    div(v-else-if="selected==='Входящие'") Входящие
    div(v-else-if="selected==='Когда-нибудь'") Когда-нибудь
    div(v-else) {{selected}}, {{date | moment('D MMM YYYY')}}
  .time.l-column(v-if="needTime")
    template(v-if="time==null")
      v-button(@click.native="time='00:00'") Указать время
    v-input-container(v-else)
      label Время
      v-input(type="time" v-model="time" @change="change")


</template>

<script lang="coffee">
import Repeat from './repeat/Repeat.vue'

component =
  name: 'dates'
  components: { Repeat }
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
    change: -> @$nextTick ->
      @time = null if _.isEmpty @time
      if @time?
        @task.date = moment(@date+' '+@time).toDate()
      else
        @task.date = moment(@date).toDate()
      if @chose then @selected = 'Выбрать'; return
      if @repeat then @selected = 'Повторять'; return
      # если совпадает дата с датой, указанной в кнопке
      for button in @buttons
        if button.date is @date
          @selected = button.name
          return
      @selected = 'Выбрать'
      @chose = yes

  data: ->
    date: moment(@task.date).format('YYYY-MM-DD')
    time: @task.time
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
.v-button
  margin 1px
  min-width 34px
  min-height 34px
  height 34px
.date
  text-align center
  margin 8px 0
  height 32px
  .v-input-container
    padding-top 0
    height 32px
    min-height 32px
.actions
  .v-button
    margin 8px
</style>
