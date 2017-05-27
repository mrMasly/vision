<template lang="jade">
textarea.v-input(:value='value', :disabled='disabled', :required='required', :placeholder='placeholder', :maxlength='maxlength', @focus='onFocus', @blur='onBlur', @input='onInput')
</template>

<script lang="coffee">
import autosize from 'autosize'
import common from '../common.js'
import getClosestVueParent from '../../../utils/getClosestVueParent.js'
component =
  name: 'v-textarea'
  mixins: [ common ]
  watch:
    value: ->
      @$nextTick -> autosize.update @$el
  mounted: ->
    @$nextTick ->
      @parentContainer = getClosestVueParent(@$parent, 'v-input-container')
      if !@parentContainer
        @$destroy()
        throw new Error('You should wrap the v-textarea in a v-input-container')
      @setParentDisabled()
      @setParentRequired()
      @setParentPlaceholder()
      @handleMaxLength()
      @updateValues()
      if !@$el.getAttribute('rows')
        @$el.setAttribute 'rows', '1'
      autosize @$el
      setTimeout =>
        autosize.update @$el
      , 500
  beforeDestroy: ->
    autosize.destroy @$el

return component
</script>
