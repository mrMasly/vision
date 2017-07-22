<template lang="jade">
div
  template(v-if="!task.disabled.date")
    .l-row
      v-button.v-icon-button.l-flex(v-for="type in types"
      @click.native="select(type)",
      :class="[{'v-primary': (type.id == active)}]",
      :disabled="!changeableDate")
        v-icon {{type.icon}}
        v-tooltip {{type.name}}

    Repeat(v-if="repeat", :task="task")
    .date(v-else-if="chose")
      v-input-container
        v-input(type="date" v-model="date")
  
  template(v-if="!task.disabled.time")
    .time.l-column(v-if="needTime")
      template(v-if="time==null")
        v-button(@click.native="setTime") Указать время
      v-input-container(v-else)
        label Время
        v-input(type="time" v-model="time" ref="time")

</template>

<script lang="coffee">
import _ from 'lodash'
import Repeat from './repeat/Repeat.vue'

component =
  name: 'date'
  components: { Repeat }
  data: ->
    types = [
      {id: 'inbox', name: 'Входящие', icon: 'inbox', date: null}
      {id: 'today', name: 'Сегодня', icon: 'today', date: moment().format('YYYY-MM-DD')}
      {id: 'tomorrow', name: 'Завтра', icon: 'filter_1', date: moment().add(1, 'day').format('YYYY-MM-DD')}
      {id: 'nextweek', name: 'Через неделю', icon: 'filter_7', date: moment().add(7, 'day').format('YYYY-MM-DD')}
      {id: 'someday', name: 'Когда-нибудь', icon: 'cloud', date: no }
      {id: 'chose', name: 'Выбрать', icon: 'date_range', select: =>
        @chose = yes
        @date = moment().format('YYYY-MM-DD') if _.isEmpty @date
      }
      {id: 'repeat', name: 'Повторять', icon: 'autorenew', select: =>
        @repeat = yes
      }
    ]
    if @task.parent then types = _.dropRight types

    date: if @task.date then moment(@task.date).format('YYYY-MM-DD') else @task.date
    time: if @task.time then moment(@task.date).format('HH:mm:ss') else null
    chose: no
    repeat: no
    types: types
  props:
    task: Object
  created: ->
    if @task.repeat.toggle
      @select _.find @types, id: 'repeat'
    else if not _.find(@types, date: @date)
      @select _.find @types, id: 'chose'
    else 
      @select _.find @types, date: @date
  methods:
    select: (type) ->
      @chose = no
      @repeat = no
      if type.select? then do type.select
      else @date = type.date
    setTime: ->
      @time = '09:00'
      @$nextTick => @$refs.time.$el.focus()
    update: ->
      if @date in [null, no]
        @task.date = @date
        @time = null
        @task.time = no
      else if @time
        @task.date = moment(@date+' '+@time).toDate()
        @task.time = yes
      else
        @task.date = moment(@date).toDate()
        @task.time = no
        @time = null
  computed:
    active: ->
      if @repeat then return 'repeat'
      else if @chose then return 'chose'
      else _.find(@types, date: @date).id
    needTime: -> @date not in [null, no]
    changeableDate: ->
      if @task.done then return no
      return yes

      
  watch:
    date: -> do @update
    time: -> do @update
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
