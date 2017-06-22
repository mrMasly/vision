<template lang="jade">
.v-checkbox(:class='[themeClass, classes]' @click="toggleCheck")
  .v-checkbox-container(@click.stop='toggleCheck', tabindex='0' ref="container")
    input(type='checkbox', :name='name', :id='id', :disabled='disabled', :value='value', :checked='checked', tabindex='-1')
    v-ripple(:disabled='disabled')
  label.v-checkbox-label(:for='id || name', v-if='$slots.default')
    slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js';
component =
  name: 'v-checkbox'
  props:
    name: String
    value: [String, Boolean]
    id: String
    disabled: Boolean
  mixins: [ theme ]
  data: ->
    checked: @value
  computed:
    classes: ->
      'v-checked': @checked
      'v-disabled': @disabled
  watch:
    value: ->
      @checked = ! !@value
  methods:
    toggleCheck: ($event) ->
      if !@disabled
        @checked = !@checked
        @$emit 'change', @checked, $event
        @$emit 'input', @checked, $event

return component
</script>
