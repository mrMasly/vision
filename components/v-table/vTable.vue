<template lang="jade">
.v-table(:class='[themeClass]')
  table
    slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
import getClosestVueParent from '../../utils/getClosestVueParent.js';
component =
  name: 'v-table'
  props:
    vSortType: String
    vSort: String
  mixins: [ theme ]
  data: ->
    sortType: @vSortType
    sortBy: @vSort
    hasRowSelection: false
    data: []
    numberOfRows: 0
    numberOfSelected: 0
    selectedRows: {}
  methods:
    emitSort: (name) ->
      @sortBy = name
      @$emit 'sort',
        name: name
        type: @sortType
    emitSelection: ->
      @$emit 'select', @selectedRows
  watch:
    data: ->
      @numberOfRows = @data.length
    selectedRows: ->
      @numberOfSelected = Object.keys(@selectedRows).length
  mounted: ->
    @parentCard = getClosestVueParent(@$parent, 'v-table-card')
    if @parentCard
      @parentCard.tableInstance = this

return component
</script>
