<template lang="jade">
div
  v-button.add(@click.native="createSubs"
  v-if="addButton") Добавить подзадачи
  div.subs(ref="subs" v-else-if="task.subs && task.subs.length")
    .v-caption Подзадачи
    Subb(v-for="(sub, index) in task.subs",
    :key="sub.id", :sub="sub", :index="index", :task="task"
    @keydown="keydown", @remove="remove" @save="save")
    .plus(@click="add()" v-if="!task.disabled.subs")
      v-icon add
      
      
</template>

<script lang="coffee">
import _ from 'lodash'
import Subb from './Sub.vue'
component =
  name: 'Subs'
  components: { Subb }
  props:
    task: Object
  created: ->
    @save = _.debounce @save, 300
  computed:
    addButton: ->
      return no if @task.disabled.subs
      size = _.get @task, 'subs.length'
      unless size then yes else no
  methods:
    save: ->
      Mongo.Tasks.update @task._id, $set:
        subs: @task.subs
      , (err, res) =>
        console.log err
    remove: (index) ->
      return if @task.disabled.subs
      parts = [
        @task.subs.slice(0,index)
        @task.subs.slice(index+1)
      ]
      @task.subs = _.union parts[0], parts[1]
      focus = index-1
      setTimeout =>
        $(@$refs.subs).find(".sub:eq(#{focus})").find('textarea').focus()
    add: (index) ->
      return if @task.disabled.subs
      index ?= @task.subs.length-1
      parts = [
        @task.subs.slice(0,index+1)
        @task.subs.slice(index+1)
      ]
      one = [{done: no, title: '', id: Random.id()}]
      @task.subs = _.union parts[0], one, parts[1]
      @focus index+1
    remove: (index) ->
      return if @task.disabled.subs
      parts = [
        @task.subs.slice(0,index)
        @task.subs.slice(index+1)
      ]
      @task.subs = _.union parts[0], parts[1]
      @focus index-1
    focus: (index) ->
      setTimeout =>
        $(@$refs.subs).find(".sub:eq(#{index})").find('textarea').focus()
    keydown: (index, e) ->
      if e.keyCode is 13 and not e.shiftKey
        e.preventDefault()
        @add index
      # при нажатии на backspace убираем пустую задачу
      else if e.keyCode is 8 and _.isEmpty e.target.value
        @remove index
      # при нажатии на стрелку вниз выбираем следующую задачу
      else if e.keyCode is 40
        if index < @task.subs.length
          @focus(index+1)
      # при нажатии на стрелку вверх выбираем предыдущую задачу
      else if e.keyCode is 38
        if index isnt 0
          @focus index-1

    createSubs: ->
      @$set @task, 'subs', [{done: no, title: '', id: Random.id()}]
      setTimeout => $(@$refs.subs).find('textarea').focus()
return component
</script>

<style lang="stylus" scoped>
.subs
  margin-top 12px
.add
  width 100%
  width calc(100% - 16px)
  text-align center
.plus
  height 28px
  transition background-color .2s
  cursor pointer
  &:hover
    background-color rgba(0,0,0,0.1)
  .v-icon
    margin 1px
    color rgba(0,0,0,0.54)
</style>
