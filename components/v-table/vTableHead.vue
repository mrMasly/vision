<template lang="jade">
th.v-table-head(:class='classes', @click='changeSort')
  .v-table-head-container
    .v-table-head-text.v-test
      v-icon.v-sortable-icon(v-if='sortBy') arrow_upward
      slot
      v-tooltip(v-if='tooltip') {{ tooltip }}
    v-ripple(:disabled='!sortBy')
</template>

<script lang="coffee">
import getClosestVueParent from '../../utils/getClosestVueParent.js'
component =
  name: 'v-table-head'
  props:
    numeric: Boolean
    sortBy: String
    tooltip: String
  data: ->
    sortType: null
    sorted: false
    parentTable: {}
  computed: classes: ->
    matchSort = @hasMatchSort()
    if !matchSort
      @sorted = false
    return {
      'v-numeric': @numeric
      'v-sortable': @sortBy
      'v-sorted': matchSort and @sorted
      'v-sorted-descending': matchSort and @sortType == 'desc'
    }
  methods:
    hasMatchSort: ->
      @parentTable.sortBy == @sortBy
    changeSort: ->
      if @sortBy
        if @sortType == 'asc' and @sorted
          @sortType = 'desc'
        else
          @sortType = 'asc'
        @sorted = true
        @parentTable.sortType = @sortType
        @parentTable.emitSort @sortBy
  mounted: ->
    @parentTable = getClosestVueParent(@$parent, 'v-table')
    if @hasMatchSort()
      @sorted = true
      @sortType = @parentTable.sortType

return component
</script>
