<template lang="jade">
.v-radio(:class='[themeClass, classes]')
  .v-radio-container(@click='toggleCheck')
    input(type='radio', :name='name', :id='id', :disabled='disabled', :value='value')
    v-ripple(:v-disabled='disabled')
  label.v-radio-label(:for='id || name', v-if='$slots.default')
    slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-radio'
  props:
    name: String
    id: String
    value: [String, Boolean, Number]
    vValue:
      type: [String, Boolean, Number]
      required: true
    disabled: Boolean
  mixins: [ theme ]
  computed:
    classes: ->
      'v-checked': typeof @value != 'undefined' and @vValue.toString() == @value.toString()
      'v-disabled': @disabled
  methods: toggleCheck: ($event) ->
    if !@disabled
      @$emit 'change', @vValue, $event
      @$emit 'input', @vValue, $event

return component
</script>
