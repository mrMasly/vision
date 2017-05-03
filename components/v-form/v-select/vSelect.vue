<template lang="jade">
.v-select(ref="select")
  select
  .v-select-value(v-if="!multiple") {{title}}
  .v-select-value(v-else)
    div(v-for="one in title") {{one}}
  .v-select-fill(@click="open")
  v-panel(ref="panel" align="select" x="start" y="start" @close="close")
    v-select-panel(ref="selectPanel" @change="change",
    :style="{minWidth: style.width, maxHeight: style.height}",
    :multiple="multiple", :value="value", :searching="searching", @close="$refs.panel.close()")
      slot
</template>

<script lang="coffee">
import _ from 'lodash'
import vSelectPanel from './vSelectPanel.vue'
import getClosestVueParent from '../../../utils/getClosestVueParent.js'
import common from '../common.js'
component =
  name: 'v-select'
  components: { vSelectPanel }
  mixins: [ common ]
  data: ->
    style:
      width: null
      height: null
    title: null
    searching: !!@search
    parentContainer: null
  computed:
    labelClass: ->
      value = if _.isNumber(@value) then String(@value) else @value
      if _.isEmpty value then 'v-placeholder'
      else 'v-caption'
  watch:
    value: -> do @update
  mounted: ->
    @parentContainer = getClosestVueParent(@$parent, 'v-input-container')
    if !@parentContainer
      @$destroy()
      throw new Error('You should wrap the v-input in a v-input-container')
    @$nextTick ->
      do @update
  created: ->
    if @height
      @style.height = _.toString @height
      @style.height = @style.height+'px' if @style.height.indexOf('px') is -1

    if @multiple
      unless @value?
        value = []
      else if not _.isArray @value
        value = [@value]
    else
      if _.isArray @value
        value = @value[0]
    if value
      @$emit 'input', value
      @$emit 'change', value
  props:
    value:
      required: yes
    multiple: [String, Boolean]
    search: [String, Boolean]
    height:
      type: [String, Number]
      default: 400
    width: [String, Number]
  methods:
    open: ->
      if @width?
        @style.width = @width+'px'
      else
        @style.width = $(@$refs.select).width()+'px'
      @$refs.panel.open()
      @$nextTick =>
        @$refs.selectPanel.open()
    close: ->
      @$refs.selectPanel.close()
      value = @$refs.selectPanel.val
      @$emit 'input', value
      @$emit 'change', value
    update: ->
      # return unless @active
      return unless @$slots.default?
      getText = (children) ->
        return null unless children?
        text = ''
        for child in children
          if child.children
            subtext = getText child.children
            text += subtext if subtext?
          text += child.text if child.text?
        return text

      @title = if @multiple then [] else null
      for option in @$slots.default
        val = _.get option, 'componentOptions.propsData.value'
        if @multiple
          if val in @value
            @title.push getText option.componentOptions.children
        else
          if val is @value
            @title = getText option.componentOptions.children
      # do @$forceUpdate
    change: (value) ->
      @$emit 'input', value
      @$emit 'change', value
      @$nextTick ->
        do @update

return component
</script>
