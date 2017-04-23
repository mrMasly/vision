<template lang="jade">
.v-select(ref="select" @click="open")
  .v-select-label(:class="[labelClass]") {{label}}
  .v-select-value(v-if="!multiple") {{title}}
  .v-select-value(v-else)
    div(v-for="one in title") {{one}}
  v-panel(ref="panel" align="select" x="start" y="start" alive)
    v-select-panel(ref="selectPanel" @close="close" @change="change",
    :style="{minWidth: style.width, maxHeight: style.height}", :multiple="multiple", :value="value", :searching="searching")
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
      if _.isEmpty @value then 'md-placeholder'
      else 'md-caption'
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
      @$refs.panel.close()
    update: ->
      children = _.get @, '$children[0].$children[0].$children'
      return unless children?
      if @multiple
        @title = []
        for child in children
          if child.value in @value
            @title.push $(child.$el).text()
      else
        @title = null
        for child in children
          if child.value is @value
            @title = $(child.$el).text()
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
