<template lang="jade">
.v-table-alternate-header(:class='[themeClass, classes]')
  v-toolbar
    .v-counter
      span(ref='counter') {{ tableInstance.numberOfSelected }}
      span {{ vSelectedLabel }}
    slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
import getClosestVueParent from '../../utils/getClosestVueParent.js'
component =
  name: 'v-table-alternate-header'
  props:
    vSelectedLabel:
      type: String
      default: 'selected'
  mixins: [ theme ]
  data: ->
    classes: {}
    tableInstance: {}
  mounted: ->
    @parentCard = getClosestVueParent(@$parent, 'v-table-card')
    @$nextTick ->
      @tableInstance = @parentCard.tableInstance
      @$watch 'tableInstance.numberOfSelected', ->
        @$refs.counter.textContent = @tableInstance.numberOfSelected
        @classes = 'v-active': @tableInstance.numberOfSelected > 0

return component
</script>
