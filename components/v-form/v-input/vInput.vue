<template lang="jade">
input.v-input(:type='type', :value='value', :disabled='disabled', :required='required', :placeholder='placeholder', :maxlength='maxlength', @focus='onFocus', @blur='onBlur', @input='onInput', @keydown.up='onInput', @keydown.down='onInput')
</template>

<script lang="coffee">
import getClosestVueParent from '../../../utils/getClosestVueParent.js'
import common from '../common.js'
component =
  name: 'v-input'
  mixins: [ common ]
  props:
    type:
      type: String
      default: 'text'
  mounted: ->
    @$nextTick ->
      @parentContainer = getClosestVueParent(@$parent, 'v-input-container')
      if !@parentContainer
        @$destroy()
        throw new Error('You should wrap the v-input in a v-input-container')
      @setParentDisabled()
      @setParentRequired()
      @setParentPlaceholder()
      @handleMaxLength()
      @updateValues()

return component
</script>
