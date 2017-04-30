<template lang="jade">
.v-input-container(:class='[themeClass, classes]')
  slot
  span.v-count(v-if='enableCounter') {{ inputLength }} / {{ counterLength }}
  v-button.v-icon-button.v-toggle-password(@click.native='togglePasswordType', v-if='hasPassword')
    v-icon {{ showPassword ? &apos;visibility_off&apos; : &apos;visibility&apos; }}
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
import {isArray} from 'lodash'
component =
  name: 'v-input-container'
  props:
    inline: Boolean
    hasPassword: Boolean
  mixins: [ theme ]
  data: ->
    value: ''
    input: false
    showPassword: false
    enableCounter: false
    hasSelect: false
    hasPlaceholder: false
    hasFile: false
    isDisabled: false
    isRequired: false
    isFocused: false
    counterLength: 0
    inputLength: 0
  computed:
    hasValue: ->
      if isArray(@value)
        return @value.length > 0
      Boolean @value
    classes: ->
      'v-input-inline': @inline
      'v-has-password': @hasPassword
      'v-has-select': @hasSelect
      'v-has-file': @hasFile
      'v-has-value': @hasValue
      'v-input-placeholder': @hasPlaceholder
      'v-input-disabled': @isDisabled
      'v-input-required': @isRequired
      'v-input-focused': @isFocused
  methods:
    isInput: ->
      @input and @input.tagName.toLowerCase() == 'input'
    togglePasswordType: ->
      if @isInput()
        if @input.type == 'password'
          @input.type = 'text'
          @showPassword = true
        else
          @input.type = 'password'
          @showPassword = false
        @input.focus()
      return
    setValue: (value) ->
      @value = value
  mounted: ->
    @input = @$el.querySelectorAll('input, textarea, select, .v-file')[0]
    if !@input
      @$destroy()
      throw new Error('Missing input/select/textarea inside v-input-container')

return component
</script>
