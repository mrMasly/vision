<template lang="jade">
th.v-table-head(:class='classes', @click='changeSort')
  .v-table-head-container
    .v-table-head-text.v-test
      v-icon.v-sortable-icon(v-if='vSortBy') arrow_upward
      slot
      v-tooltip(v-if='vTooltip') {{ vTooltip }}
    v-ripple(:v-disabled='!vSortBy')
</template>

<script lang="coffee">
import getClosestVueParent from '../../utils/getClosestVueParent.js'
component =
  name: 'v-table-head'
  props:
    vNumeric: Boolean
    vSortBy: String
    vTooltip: String
  data: ->
    sortType: null
    sorted: false
    parentTable: {}
  computed: classes: ->
    matchSort = @hasMatchSort()
    if !matchSort
      @sorted = false
    return {
      'v-numeric': @vNumeric
      'v-sortable': @vSortBy
      'v-sorted': matchSort and @sorted
      'v-sorted-descending': matchSort and @sortType == 'desc'
    }
  methods:
    hasMatchSort: ->
      @parentTable.sortBy == @vSortBy
    changeSort: ->
      if @vSortBy
        if @sortType == 'asc' and @sorted
          @sortType = 'desc'
        else
          @sortType = 'asc'
        @sorted = true
        @parentTable.sortType = @sortType
        @parentTable.emitSort @vSortBy
  mounted: ->
    @parentTable = getClosestVueParent(@$parent, 'v-table')
    if @hasMatchSort()
      @sorted = true
      @sortType = @parentTable.sortType

return component
</script>
