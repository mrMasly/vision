<template lang="jade">
.toolbar.l-row.l-fill.l-start-center.l-relative(ref="toolbar")
  input.l-flex(placeholder="Добавить задачу"
  v-model="task.title"
  @keydown.enter.prevent.stop="save(task)"
  ref="input")

  v-caption.date(v-if="displayDate") {{dateFormat}}

  v-button.v-icon-button.v-primary.settings(@click.native="$refs.panel.open();saveOnEnter=true" v-if="settings")
    v-icon settings

  v-button.v-icon-button.v-primary.ok(@click.native="save(task)" v-if="ok")
    v-icon check

  v-panel(ref="panel" align="toolbar" x="end" y="after" alive v-if="task")
    Edit.edit(:actions="true", :texts="false", :fabs="false" ref="edit"
      @close="$refs.panel.close();saveOnEnter=false", v-model="task", @save="save",
      :save-on-enter="saveOnEnter")
  
  .saving(v-if="saving")
    v-progress(indeterminate)
</template>

<script lang="coffee">
import _ from 'lodash'
import Edit from '../edit/Edit.vue'
getTask = (params) ->
  task = 
    title: ''
    date: null
    time: no
    priority: 1
    users: []
    disables: []
    tags: []
    done: no
    doneAt: null
    viewed: yes
    just: no
    repeat:
      type: 'day'
      date:
        start: moment().format('YYYY-MM-DD')
        end: null
        time: null
      toggle: no
      week: []
      month:
        type: 'month'
        index: ['first']
        weekDay: [0]
        monthDays: []
  for key, val of params
    _.set task, key, val
  return task
component =
  name: 'add'
  components: { Edit }
  props:
    settings:
      type: Boolean
      default: yes
    ok:
      type: Boolean
      default: yes
    params: Object
    focus:
      type: Boolean
      default: no
  created: ->
    @resize = _.debounce @resize, 300
  mounted: ->
    $(window).on 'resize', @resize
    do @resize
    if @focus then @$nextTick ->
      @$refs.input.focus()
  destroy: ->
    $(window).off 'resize', @resize
  data: ->
    displayDate: no
    saving: no
    task: getTask(@params)
    display: yes
    saveOnEnter: no
  methods:
    save: (task) ->
      if _.isEmpty task.title
        @$toast 'Введите название задачи'
      else
        @saving = yes
        Mongo.Tasks.insert task, (err, res) =>
          @saving = no
          if err then @$toast 'Ошибка при сохранении задачи'
          else
            @task = getTask @params
            @$emit 'save'
      @$refs.panel.close()
    resize: ->
      width = $(@$el).width()
      @displayDate = width > 480
  computed:
    dateFormat: ->
      if @task.repeat.toggle
        return "Повторяется"
      date = @$refs.edit.task.date
      require('../fromnow.coffee')(date, no, no)
  watch:
    params: -> @task = getTask @params
return component
</script>

<style lang="stylus" scoped>
.toolbar
  height 48px
  padding 0 0 0 8px
input
  font-size 16px
  border none
  outline none
  box-shadow none
.v-speed-dial
  position relative
  top 5px
.saving
  position absolute
  bottom 0
  left 0
  width 100%
  height 4px
  z-index 2
.settings
  margin-right 0
.ok
  margin-left 0
.edit
  position relative !important
</style>
