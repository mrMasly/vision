<template lang="jade">
.toasts

  md-snackbar(md-position="top right" ref="top" v-bind:md-duration="top.duration"
  @click.native="top.click")
    md-button.md-icon-button.close(@click.native.prevent.stop="top.close")
      md-icon close
    .layout-column.has-ripple
      md-ink-ripple
      .title.md-Subheading(v-if="top.title") {{top.title}}
      .text.md-body(v-if="top.text") {{top.text}}

  md-snackbar(md-position="bottom right" ref="bottom" v-bind:md-duration="bottom.duration"
  @click.native="bottom.click")
    md-button.md-icon-button.close(@click.native.prevent.stop="bottom.close")
      md-icon close
    .layout-column
      .title.md-Subheading(v-if="bottom.title") {{bottom.title}}
      .text.md-body(v-if="bottom.text") {{bottom.text}}
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
    @default =
      top: _.clone @top
      bottom: _.clone @bottom
  data: ->
    default: null
    top:
      duration: 5000
      text: null
      title: null
      cb: null
      click: => do @top.cb if @top.cb
      close: (e) => do @$refs.top.close
    bottom:
      duration: 5000
      text: null
      title: null
      cb: null
      click: => do @top.cb if @top.cb
      close: (e) => do @$refs.bottom.close
  methods:
    open: (data, cb) ->
      data = text: data unless _.isObject data
      type = data.type ? 'top'
      for key, val of @default[type]
        data[key] ?= val
      data.cb ?= cb
      @[type] = data
      do @$refs[type].open

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
