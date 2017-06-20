<template lang="jade">
.v-option(:class="[{focus: focus}]" v-show="show" @click="select" @mousemove="mousemove")
  //- .l-relative
  v-ripple(v-if="panel")
  .l-row.l-start-center.l-relative(v-if="panel && panel.multiple")
    v-checkbox(v-model="checked")
    slot.l-flex
    .hover
  div(v-else, :class="[{checked: checked}]")
    slot
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'v-option'
  data: ->
    focus: no
    show: yes
    checked: no
    panel: null
  props:
    value:
      required: yes
    multiple: [String, Boolean]
    search: [String, Number, Array]
  created: ->

  mounted: ->
    do @getPanel
    do @update
  methods:
    getPanel: ->
      return if $(@$parent.$el).is('.v-select')
      parent = @
      for i in [0..10]
        return null unless parent?
        if parent.$el? and $(parent.$el).is('.v-select-panel')
          @panel = parent
          break
        else
          parent = parent.$parent
    update: ->
      return unless @panel
      if @panel.multiple
        @checked = @value in @panel.val
      else
        @checked = @value is @panel.val
    select: ->
      return unless @panel
      @panel.select @value
      @checked = not @checked
    mousemove: ->
      return if @focus
      return unless @panel
      key = @$vnode.key
      options = @$parent.$slots.default
      index = _.findIndex options, key: key
      @panel.focus index
return component
</script>
