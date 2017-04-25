<template lang="jade">
.v-select(ref="select" @click="open")
  .v-select-label(:class="[labelClass]") {{label}}
  .v-select-value(v-if="!multiple") {{title}}
  .v-select-value(v-else)
    div(v-for="one in title") {{one}}
  //- .v-select-value
  //-   slot(name="selected")
  v-panel(ref="panel" align="select" x="start" y="start" @close="close")
    v-select-panel(ref="selectPanel" @change="change",
    :style="{minWidth: style.width, maxHeight: style.height}",
    :multiple="multiple", :value="value", :searching="searching", @close="$refs.panel.close()")
      slot
</template>

<script lang="coffee">
import _ from 'lodash'
import vSelectPanel from './v-select-panel.vue'
component =
  name: 'v-select'
  components: { vSelectPanel }
  data: ->
    style:
      width: null
      height: null
    title: null
    searching: !!@search
  computed:
    labelClass: ->
      value = if _.isNumber(@value) then String(@value) else @value
      if _.isEmpty value then 'md-placeholder'
      else 'md-caption'
  watch:
    value: -> do @update
  mounted: ->
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
    label: String
    search: [String, Boolean]
    height: [String, Number]
  methods:
    open: ->
      @style.width = $(@$refs.select).width()+'px'
      @$refs.panel.open()
      @$nextTick =>
        @$refs.selectPanel.open()
    close: ->
      value = @$refs.selectPanel.val
      @$emit 'input', value
      @$emit 'change', value

    # closePanel: ->
    #   @$refs.panel.close()
    update: ->
      getText = (children) ->
        return null unless children?
        text = ''
        for child in children
          if child.children
            subtext = getText child.children
            text += subtext if subtext?
          text += child.text if child.text?
        return text

      # slots = []
      @title = if @multiple then [] else null
      for option in @$slots.default
        val = _.get option, 'componentOptions.propsData.value'
        if @multiple
          if val in @value
            @title.push getText option.componentOptions.children
            # console.log text
            # slots.push option
        else
          if val is @value
            # slots.push option
            @title = getText option.componentOptions.children
      # @$slots.selected = slots
      do @$forceUpdate
    change: (value) ->
      @$emit 'input', value
      @$emit 'change', value
      @$nextTick ->
        do @update

return component
</script>



<style lang="stylus" scoped>
.v-select
  cursor pointer
  width 100%
  position relative
  height auto
  box-sizing border-box
  padding-top 20px
  margin 8px 0
.v-select-value
  display block
  width 100%
  position relative
  min-height 25px
  line-height 20px
  font-size 16px
  border-bottom solid 1px rgba(0, 0, 0, .15)
  box-sizing border-box
  &:hover
    &:after
      color rgba(0, 0, 0, .54)
  &:after
    color rgba(0, 0, 0, .38)
    margin-top 2px
    position absolute
    top 50%
    right 0
    transform translateY(-50%) scaleY(.45) scaleX(.85)
    transition all .15s linear
    content "\25BC"
    box-sizing inherit

.v-select-label
  position absolute
  &.md-placeholder
    top 20px
    font-size 16px
    color rgba(0,0,0,.54)
  &.md-caption
    top 0px

</style>
