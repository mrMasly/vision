<template lang="jade">
.toasts
  md-snackbar(v-bind:md-position="toast.position" ref="toast" v-bind:md-duration="toast.duration"
  @click.native="click" @close="onClose")
    md-button.md-icon-button.close(@click.native.prevent.stop="close")
      md-icon close
    .layout-column.has-ripple
      md-ink-ripple
      .title.md-Subheading(v-if="toast.title") {{toast.title}}
      .text.md-body(v-if="toast.text") {{toast.text}}
</template>

<script lang="coffee">
import _ from 'lodash'


component =
  module: module
  name: 'Toasts'
  created: ->
    @$store.commit 'linkComponent',
      component: @
      id: 'toasts'
    @default = _.clone @toast
  data: ->
    queue: []
    default: null
    toast:
      duration: 5000
      text: null
      title: null
      cb: null
    click: =>
      if @toast.cb?
        do @toast.cb
      else
        do @close
    close: (e) => do @$refs.toast.close
  methods:
    # добавить уведомление в очередь
    add: (data, cb) ->
      data = text: data unless _.isObject data
      type = data.type ? 'top'
      data.position ?= "#{type} right"
      data[key] ?= val for key, val of @default
      data.cb ?= cb
      @queue.push data
      do @tick
    # запускает первое уведомление в очереди
    tick: ->
      if _.isEmpty @queue then return
      if @_opened then return
      else @_opened = yes
      queue = _.clone @queue
      toast = queue.shift()
      @toast = toast
      @queue = queue
      do @$refs.toast.open
    # при закрытии
    onClose: ->
      @_opened = no
      setTimeout =>
        do @tick
      , 300







return component
</script>

<style lang="stylus" scoped>
.layout-column > div
  width 100%
  &:first-child
    width calc(100% - 50px)
.close
  position absolute
  top 11px
  right 20px
  min-width 40px !important
</style>
