<template lang="jade">
.toolbar.l-row.l-fill.l-start-center.l-relative(ref="toolbar")
  input.l-flex(placeholder="Добавить задачу"
  v-model="task.title"
  @keydown.enter="save(task)"
  ref="input")

  v-caption.date(v-if="displayDate") {{dateFormat}}

  v-button.v-icon-button.v-primary.settings(@click.native="$refs.panel.open();saveOnEnter=true" v-if="settings")
    v-icon settings

  v-button.v-icon-button.v-primary.ok(@click.native="save(task)" v-if="ok")
    v-icon check

  v-panel(ref="panel" align="toolbar" x="end" y="after" alive v-if="task")
    Edit(:actions="true", :texts="false", :fabs="false" ref="edit"
      @close="$refs.panel.close();saveOnEnter=false", v-model="task", @save="save",
      :save-on-enter="saveOnEnter")
  
  .saving(v-if="saving")
    v-progress(indeterminate)
</template>

<script lang="coffee">
import _ from 'lodash'
import Edit from '../edit/Edit.vue'
getTask = (date) ->
  title: ''
  date: date
  time: no
  priority: 1
  users: []
  disables: []
  tags: []
  repeat:
    type: 'week'
    date:
      start: null
      end: null
    toggle: no
    week: []
    month:
      type: 'month'
      index: 'first'
      weekDay: 0
      monthDays: []
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
    date: [Date, Boolean]
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
    task: getTask(@date)
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
            @task = getTask @date
            @$emit 'save'
    resize: ->
      width = $(@$el).width()
      @displayDate = width > 600
  computed:
    dateFormat: ->
      date = @$refs.edit.task.date
      require('../fromnow.coffee')(date, no, no)
  watch:
    date: ->
      @task = getTask @date
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
</style>
