<template lang="jade">
div
  v-button.v-primary.add(@click.native="createSubs"
  v-if="addButton") Добавить подзадачи
  .l-padding(ref="subs" v-else)
    .v-caption Подзадачи
    Subb(v-for="(sub, index) in task.subs",
    :key="sub.id", :sub="sub", :index="index",
    @keydown="keydown", @remove="remove" @save="save")

</template>

<script lang="coffee">
import _ from 'lodash'
import Subb from './Sub.vue'

component =
  name: 'Subs'
  components: { Subb }
  props:
    task: Object
  computed:
    addButton: ->
      size = _.get @task, 'subs.length'
      unless size then yes else no
  methods:
    save: -> @$emit 'save'
    remove: (index) ->
      parts = [
        @task.subs.slice(0,index)
        @task.subs.slice(index+1)
      ]
      @task.subs = _.union parts[0], parts[1]
      focus = index-1
      setTimeout =>
        $(@$refs.subs).find(".sub:eq(#{focus})").find('textarea').focus()
        do @save
    keydown: (index, e) ->
      if e.keyCode is 13
        e.preventDefault()
        parts = [
          @task.subs.slice(0,index+1)
          @task.subs.slice(index+1)
        ]
        one = [{done: no, title: '', id: Random.id()}]
        @task.subs = _.union parts[0], one, parts[1]
        focus = index+1
        do @save


      # при нажатии на backspace убираем пустую задачу
      else if e.keyCode is 8 and _.isEmpty e.target.value
        parts = [
          @task.subs.slice(0,index)
          @task.subs.slice(index+1)
        ]
        @task.subs = _.union parts[0], parts[1]
        focus = index-1

      # при нажатии на стрелку вниз выбираем следующую задачу
      else if e.keyCode is 40
        if index < @task.subs.length
          focus = index+1

      # при нажатии на стрелку вверх выбираем предыдущую задачу
      else if e.keyCode is 38
        if index isnt 0
          focus = index-1

      if focus?
        setTimeout =>
          $(@$refs.subs).find(".sub:eq(#{focus})").find('textarea').focus()
          do @save
    createSubs: ->
      @$set @task, 'subs', [{done: no, title: '', id: Random.id()}]
      setTimeout => $(@$refs.subs).find('textarea').focus()
      do @save
return component
</script>

<style lang="stylus" scoped>

.add
  width 100%
  width calc(100% - 16px)
  text-align center
</style>
