<template lang="jade">
.v-chips(:class='[themeClass, classes]')
  v-input-container(@click.native='applyInputFocus')
    v-chip(v-for='chip in selectedChips', :v-deletable='!vStatic', :disabled='disabled', @delete='deleteChip(chip)')
      slot(:value='chip')
    v-input(v-show='!vStatic', v-model='currentChip', :type='vInputType', :placeholder='vInputPlaceholder', :id='inputId', :name='vInputName', :disabled='disabled', @keydown.native.delete='deleteLastChip', @keydown.native.prevent.enter='addChip', @keydown.native.prevent.186='addChip', tabindex='0', ref='input')
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-chips'
  props:
    value: Array
    disabled: Boolean
    vInputId: String
    vInputName: String
    vInputPlaceholder: String
    vInputType:
      type: String
      default: 'text'
    vStatic: Boolean
    vMax:
      type: Number
      default: Infinity
  mixins: [ theme ]
  data: ->
    currentChip: null
    selectedChips: @value
    inputId: @vInputId or 'chips-' + Random.id()
  watch:
    value: (_value) ->
      @selectedChips = _value
  computed:
    classes: ->
      'v-static': @vStatic
      'v-disabled': @disabled
  methods:
    applyInputFocus: ->
      @$nextTick ->
        @$refs.input.$el.focus()
    addChip: ->
      if @currentChip and @selectedChips.length < @vMax
        value = @currentChip.trim()
        if @selectedChips.indexOf(value) < 0
          @selectedChips.push value
          @currentChip = null
          @$emit 'input', @selectedChips
          @$emit 'change', @selectedChips
          @applyInputFocus()
    deleteChip: (chip) ->
      index = @selectedChips.indexOf(chip)
      if index >= 0
        @selectedChips.splice index, 1
      @$emit 'change', @selectedChips
      @applyInputFocus()
    deleteLastChip: ->
      if !@currentChip
        @selectedChips.pop()
        @$emit 'change', @selectedChips
        @applyInputFocus()

return component
</script>
