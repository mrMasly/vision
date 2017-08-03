<template lang="jade">
.toasts
  v-snackbar(:position="toast.position" ref="toast", :duration="toast.duration"
    @click.native="click" @close="onClose")
    v-button.v-icon-button.close(@click.native.prevent.stop="close")
      v-icon close
    .l-column
      v-ripple
      .title.v-Subheading(v-if="toast.title") {{toast.title}}
      .text.v-body(v-if="toast.text") {{toast.text}}
</template>

<script lang="coffee">
import _ from 'lodash'


component =
  module: module
  name: 'Toasts'
  created: ->
    @$store.commit 'vision/linkComponent',
      component: @
      id: 'toasts'
    @default = _.clone @toast
  data: ->
    mounted: no
    audios:
      applause: '/packages/mrmasly_vision/files/audio/applause.mp3'
      fanfar: '/packages/mrmasly_vision/files/audio/fanfar.mp3'
      fanfar1: '/packages/mrmasly_vision/files/audio/fanfar1.mp3'
      fanfar2: '/packages/mrmasly_vision/files/audio/fanfar2.mp3'
      ifeelgood: '/packages/mrmasly_vision/files/audio/ifeelgood.mp3'
      message: '/packages/mrmasly_vision/files/audio/message.wav'
      notification: '/packages/mrmasly_vision/files/audio/notification.mp3'
    audio: {}
    queue: []
    default: null
    toast:
      duration: 5000
      text: null
      title: null
      cb: null
      say: null
    click: =>
      if @toast.cb? then do @toast.cb
      else do @close
    close: (e) =>
      if @toast.close? then do @toast.close
      do @$refs.toast.close
  mounted: ->
    @mounted = yes
  methods:
    # добавить уведомление в очередь
    add: (data, cb) ->
      return unless @mounted
      data = text: data unless _.isObject data
      type = data.type ? 'top'
      data.position ?= "#{type} right"
      data[key] ?= val for key, val of @default
      # аудио
      if data.audio?
        audio = @audios[data.audio] if data.audio.indexOf('/') is -1
        if audio?
          @audio[audio] ?= new Audio audio
          data.audio = @audio[audio]
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
      setTimeout =>
        do @$refs.toast.open
        do toast.audio.play if toast.audio?
        if toast.say?
          if window.speechSynthesis and window.SpeechSynthesisUtterance
            text = new window.SpeechSynthesisUtterance toast.say
            text.onend = =>
              if toast.audio?
                setTimeout (=> toast.audio.volume = 0.3), 100
                setTimeout (=> toast.audio.volume = 0.4), 200
                setTimeout (=> toast.audio.volume = 0.5), 300
                setTimeout (=> toast.audio.volume = 0.6), 400
                setTimeout (=> toast.audio.volume = 0.7), 500
                setTimeout (=> toast.audio.volume = 0.8), 600
                setTimeout (=> toast.audio.volume = 0.9), 700
                setTimeout (=> toast.audio.volume = 1.0), 800
            if toast.audio?
              setTimeout (=> toast.audio.volume = 0.9), 2100
              setTimeout (=> toast.audio.volume = 0.8), 2200
              setTimeout (=> toast.audio.volume = 0.7), 2300
              setTimeout (=> toast.audio.volume = 0.6), 2400
              setTimeout (=> toast.audio.volume = 0.5), 2500
              setTimeout (=> toast.audio.volume = 0.4), 2600
              setTimeout (=> toast.audio.volume = 0.3), 2700
              setTimeout (=> toast.audio.volume = 0.2), 2800
              setTimeout (=> window.speechSynthesis.speak text), 2900

              
            
      , 300
    # при закрытии
    onClose: ->
      @_opened = no
      if @toast.audio?
        do @toast.audio.pause
        @toast.audio.currentTime = 0
      setTimeout =>
        do @tick
      , 1000


return component
</script>

<style lang="stylus" scoped>
.l-column > div
  width 100%
  &:first-child
    width calc(100% - 50px)
.close
  position absolute
  top 11px
  right 20px
  min-width 40px !important
</style>
