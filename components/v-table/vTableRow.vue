<template lang="jade">
tr.v-table-row(:class='classes', @click='getAutoSelect')
  v-table-row.v-table-selection(v-if='hasSelection')
    v-checkbox(v-model='checkbox', :disabled='isDisabled', @change='select')
  slot
</template>

<script lang="coffee">
import getClosestVueParent from '../../utils/getClosestVueParent.js'
transitionClass = 'v-transition-off'
component =
  name: 'v-table-row'
  props:
    autoSelect: Boolean
    selection: Boolean
    item: Object
  data: ->
    parentTable: {}
    headRow: false
    checkbox: false
    index: 0
  computed:
    isDisabled: ->
      !@selection and !@headRow
    hasSelection: ->
      @selection or @headRow and @parentTable.hasRowSelection
    classes: ->
      'v-selected': @checkbox
  watch:
    item: (newValue, oldValue) ->
      @parentTable.data[@index] = @item
      @handleMultipleSelection newValue == oldValue
  methods:
    setSelectedRow: (value, index) ->
      if value
        @parentTable.selectedRows[index] = @parentTable.data[index]
        ++@parentTable.numberOfSelected
      else
        delete @parentTable.selectedRows[index]
        --@parentTable.numberOfSelected
    handleSingleSelection: (value) ->
      @setSelectedRow value, @index - 1
      @parentTable.$children[0].checkbox = @parentTable.numberOfSelected == @parentTable.numberOfRows
    handleMultipleSelection: (value) ->
      _this = this
      if @parentTable.numberOfRows > 25
        @parentTable.$el.classList.add transitionClass
      @parentTable.$children.forEach (row, index) ->
        row.checkbox = value
        if !row.headRow
          _this.setSelectedRow value, index - 1
      if value
        @parentTable.numberOfSelected = @parentTable.numberOfRows
      else
        @parentTable.numberOfSelected = 0
      window.setTimeout ->
        _this.parentTable.$el.classList.remove transitionClass
    select: (value) ->
      if @hasSelection
        if @headRow
          @handleMultipleSelection value
        else
          @handleSingleSelection value
        @parentTable.emitSelection()
    getAutoSelect: ->
      if @autoSelect and @hasSelection
        @checkbox = !@checkbox
        @handleSingleSelection @checkbox
        @parentTable.emitSelection()
  mounted: ->
    @parentTable = getClosestVueParent(@$parent, 'v-table')
    if @$el.parentNode.tagName.toLowerCase() == 'thead'
      @headRow = true
    else
      @parentTable.numberOfRows++
      @index = @parentTable.numberOfRows
      if @selection
        @parentTable.hasRowSelection = true
      if @item
        @parentTable.data.push @item

return component
</script>
