<template lang="jade">
.v-scroller(@scroll="onScroll")
  .v-scroll-sizer(ref="sizer" v-if="$slots.default")
    div(:style="{height: offset+'px'}")
    div(:style="{height: ($slots.default.length*height)-offset+'px'}")
  .v-scroll-offseter(:style="{transform: 'translateY('+offset+'px)'}" ref="offseter")
    slot(name="visible")
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'v-scroller'
  # props:
    # height: [String, Number]
  data: ->
    offset: 0
    height: 20
    start: 0
    end: 0
    blockSize: 0
    blockHeight: 0
  created: ->
    @itemHeight = _.toNumber(@height)
    if @$slots.default?
      @$slots.visible = @$slots.default[0..10]
    do @$forceUpdate
  mounted: ->
    # console.log 'mounted'
    @$nextTick ->
      do @onScroll
      do @$forceUpdate
      setTimeout =>
        do @onScroll
        do @$forceUpdate
  methods:
    update: (start) ->
      return unless @$slots.default?
      # console.log 'update'
      @start = start if start?
      @end = @start + @blockSize - 1
      start = @start - @blockSize
      start = 0 if start < 0
      end = @start + @blockSize*2
      @offset = start * @height
      # console.log start, end
      @$slots.visible = @$slots.default[start...end]
      do @$forceUpdate
    onScroll: (hard) ->
      return unless @$slots.default?
      do @updateParams
      elScrolled = _.floor(@$el.scrollTop / @height)
      if (hard) or (@start isnt elScrolled)
        @update elScrolled
    updateParams: ->
      return unless @$slots.default?
      height = _.get @$slots, 'visible[0].elm.offsetHeight'
      @height = height if height?
      @blockSize = _.ceil @$el.offsetHeight / @height
      @blockHeight = @blockSize * @height
      @end = @start + @blockSize - 1
    # прокрутить до элемента по ключу
    scrollKey: (key) ->
      unless key then @setScrollTop 0; return
      do @updateParams
      index = _.findIndex @$slots.default, key: key
      if index > @end
        start = index - @blockSize + 1
        @setScrollTop start * @height
      else if index < @start
        start = index
        @setScrollTop start * @height

    setScrollTop: (top) ->
      @$el.scrollTop = top
      do @onScroll


return component
</script>

<style lang="stylus" scoped>
.v-scroller
  overflow auto
  position relative
.v-scroll-offseter
  position absolute
  left 0
  margin 0
  padding 0
  right 0
  top 0
</style>
