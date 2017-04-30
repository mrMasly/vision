<template lang="jade">
.md-switch(:class='[themeClass, classes]')
  .md-switch-container(@click='toggle($event)')
    .md-switch-thumb(:style='styles')
      input(type='checkbox', :name='name', :id='id', :disabled='disabled', :value='value')
      button.md-switch-holder(:type='type')
      md-ink-ripple(:md-disabled='disabled')
  label.md-switch-label(:for='id || name', v-if='$slots.default')
    slot
</template>

<script lang="coffee">

import theme from '../../theme/mixin.js'
checkedPosition = 75
initialPosition = '-1px'

component =
  name: 'v-switch'
  props:
    name: String
    value: Boolean
    id: String
    disabled: Boolean
    type:
      type: String
      default: 'button'
  mixins: [ theme ]
  data: ->
    leftPos: initialPosition
    checked: @value
  computed:
    classes: ->
      'md-checked': Boolean(@value)
      'md-disabled': @disabled
    styles: ->
      transform: 'translate3D(' + @leftPos + ', -50%, 0)'
  watch:
    checked: ->
      @setPosition()
    value: (_value) ->
      @changeState _value
  methods:
    setPosition: ->
      @leftPos = if @checked then checkedPosition + '%' else initialPosition
    changeState: (checked, $event) ->
      if typeof $event != 'undefined'
        @$emit 'change', checked, $event
        if !$event.defaultPrevented
          @checked = checked
        @$emit 'input', @checked, $event
      else
        @checked = checked
    toggle: ($event) ->
      if !@disabled
        @changeState !@checked, $event
  mounted: ->
    @$nextTick @setPosition

return component
</script>
