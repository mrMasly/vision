<template lang="jade">
.l-fill.l-column
  v-toolbar.v-transparent.v-dense.v-shadow.l-relative
    Done(:task="task" v-if="task.createdAt")
    Priority(:task="task")
    .l-flex {{date}}
    v-button.v-icon-button(@click.native="close")
      v-icon close
  .l-padding.l-scroll.l-flex
    Dates(:task="task" v-if="dates")
    Texts(:task="task" v-if="texts")
    Users(:task="task" v-if="users")
    Subs(:task="task" v-if="subs")

  .l-row.actions.l-end(v-if="actions")
    v-button.v-primary(@click.native="close") Отмена
    v-button.v-primary(@click.native="save") Сохранить
  .fabs(v-else-if="fabs")
    //- v-speed-dial.v-button-icon(open='hover' direction="top" ref="dial" @trigger="hover=arguments[0]")
    v-speed-dial.v-button-icon(open='hover' direction="top" ref="dial")
      v-button.v-fab.v-primary(fab-trigger @click.native="save")
        v-icon(icon-morph) save
        v-icon save
        v-tooltip(direction="left") (ctrl+s) Сохранить
      v-button.v-fab.v-mini(@click.native="remove")
        v-icon delete_forever
        v-tooltip(direction="left") (ctrl+d) Удалить
  v-progress(indeterminate v-if="saving")
</template>

<script lang="coffee">
import _ from 'lodash'
import Dates from './Dates.vue'
import Priority from './Priority.vue'
import Users from './Users.vue'
import Texts from './Texts.vue'
import Tags from './Tags.vue'
import Subs from './Subs.vue'
import Done from '../helpers/Done.vue'
component =
  name: 'edit'
  components: { Dates, Priority, Users, Tags, Done, Texts, Subs }
  props:
    value: Object
    actions: type: Boolean, default: no
    fabs:    type: Boolean, default: yes
    texts:   type: Boolean, default: yes
    dates:   type: Boolean, default: yes
    users:   type: Boolean, default: yes
    subs:    type: Boolean, default: yes
    saveOnEnter: Boolean
    saveOnMeta: Boolean
    removeOnMeta: Boolean
    # hotkeys: type: Boolean, default: no
  data: ->
    task: null
    saving: no
  created: ->
    do @update
    @$watch "value", (-> do @update), deep: yes
  mounted: ->
    $(document).on 'keydown', @keypress
  beforeDestroy: ->
    $(document).off 'keydown', @keypress
  methods:
    keypress: (e) ->
      if e.keyCode is 13 and @saveOnEnter
        do @save
        do e.preventDefault
        do e.stopPropagation
      else if e.key is 's' and (e.metaKey or e.ctrlKey) and @saveOnMeta
        do @save
        do e.preventDefault
        do e.stopPropagation
      else if e.key is 'd' and (e.metaKey or e.ctrlKey) and @removeOnMeta
        do @remove
        do e.preventDefault
        do e.stopPropagation
    close: -> @$emit 'close'
    save: ->
      if @task._id
        @saving = yes
        Mongo.Tasks.update @task._id, {$set: _.omit(@task, '_id')}, (err, res) =>
          @saving = no
          if err? then @$toast position: "bottom right", text: "Ошибка при сохранении задачи"
          else @$toast position: "bottom right", text: "Сохранено"
      @$emit 'save', @task
    remove: ->
      return unless @task._id
      @saving = yes
      @$confirm { title: 'Удалить задачу?', content: @task.title }, =>
        Mongo.Tasks.remove @task._id
        @saving = no
        do @close
    update: ->
      @task = _.cloneDeep @value
      @task.disabled ?= {}
      if @task.from? and @task.from isnt @task.for
        for type in ['date','time','priority','subs','title','description']
          @task.disabled[type] = yes if type in @task.disables
  computed:
    date: ->
      if @task.repeat.toggle
        date = ["Повторяется c"]
        date.push moment(@task.repeat.date.start).format('D MMM YYYY')
        date.push "в "+@task.repeat.date.time if @task.repeat.date.time
        return date.join ' '
      else
        return require('../fromnow.coffee')(@task.date)
      
return component
</script>

<style lang="stylus" scoped>
.fabs
  position absolute
  bottom 16px
  right 16px
.v-divider
  margin 8px 0
</style>
