<template lang="jade">
.absolute
  v-dialog-confirm(
    :title="confirm.title",
    :content-html="confirm.content",
    :ok-text="confirm.ok",
    :cancel-text="confirm.cancel",
    @close="onCloseConfirm"
    ref="confirm")
  v-dialog-alert(
    :title="alert.title",
    :content="alert.content",
    :ok-text="alert.ok",
    @close="onCloseAlert"
    ref="alert")
  v-dialog-prompt(
    :content="prompt.content",
    :title="prompt.title",
    :ok-text="prompt.ok",
    :cancel-text="prompt.cancel",
    :value="prompt.value",
    :input-maxlength="prompt.max",
    @close="onClosePrompt"
    @input="setVal"
    ref="prompt")
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'dialogs'

  data: ->
    confirm:
      title: null
      content: 'Вы уверены?'
      ok: 'да'
      cancel: 'отмена'
      yes: null
      no: null
    alert:
      title: null
      content: 'Внимание!'
      ok: 'хорошо'
      cb: null
    prompt:
      title: null
      content: '?'
      ok: 'ок'
      cancel: 'отмена'
      max: null
      placeholder: null
      value: ''
      yes: null
      no: null

  created: ->
    @$store.commit 'vision/linkComponent',
      component: @
      id: 'dialogs'
    @default =
      confirm: _.clone @confirm
      alert: _.clone @alert
      prompt: _.clone @prompt
  methods:

    setVal: (val) -> @prompt.val = val

    openConfirm: (data={}, yesCb, noCb) ->
      data = {content: data} if _.isString data
      data[key] ?= val for key, val of @default.confirm
      data.yes = yesCb; data.no = noCb
      @confirm = data
      @$refs.confirm.open()
    onCloseConfirm: (res) ->
      if res is 'ok' then do @confirm.yes if @confirm.yes?
      else do @confirm.no if @confirm.no?

    openAlert: (data={}, cb) ->
      data = {content: data} if _.isString data
      data[key] ?= val for key, val of @default.alert
      data.cb = cb
      @alert = data
      @$refs.alert.open()
    onCloseAlert: () ->
      do @alert.cb if @alert.cb?

    openPrompt: (data={}, yesCb, noCb) ->
      data = {content: data} if _.isString data
      data[key] ?= val for key, val of @default.prompt
      data.yes = yesCb
      data.no = noCb
      @prompt = data
      @$refs.prompt.open()
    onClosePrompt: (res) ->
      if res is 'ok' then @prompt.yes(@prompt.val) if @prompt.yes?
      else do @prompt.no if @prompt.no?

return component
</script>

<style lang="stylus" scoped>
</style>
