<template lang="jade">
.v-option(:class="[{focus: focus}]" v-show="show" @click="select" @mouseover="mouseover")
  .has-ripple
    md-ink-ripple
    .l-row.l-start-center(v-if="$parent.multiple")
      md-checkbox(v-model="checked")
      slot.l-flex
    div(v-else, :class="[{checked: checked}]")
      slot
</template>

<script lang="coffee">
component =
  name: 'v-option'
  data: ->
    focus: no
    show: yes
    checked: no
  props:
    value:
      required: yes
    multiple: [String, Boolean]
  created: ->
    do @update
  methods:
    update: ->
      if @$parent.multiple
        @checked = @value in @$parent.val
      else
        @checked = @value is @$parent.val
    select: ->
      @$parent.select @value
    mouseover: ->
      @$emit 'focus'
      options = _.filter @$parent.$children, (c) -> $(c.$el).is('.v-option') and c.show
      index = 0
      for option in options
        break if option._uid is @_uid
        index++
      @$parent.focus index
return component
</script>

<style lang="stylus" scoped>
height = 35px
.v-option
  position relative
  cursor pointer
  font-size 16px
  line-height height
  height height
  padding 0 16px
  display block
  transition background-color .1s
  &.focus
    background-color rgba(0, 0, 0, 0.1)
.md-checkbox
  margin 0
  margin-right 12px
.checked
  color #2196f3
</style>
