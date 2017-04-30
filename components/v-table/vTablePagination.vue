<template lang="jade">
.v-table-pagination
  span.v-table-pagination-label {{ vLabel }}:
  v-select(v-model='currentSize', v-menu-class='v-pagination-select', @change='changeSize', v-if='pageOptions')
    v-option(v-for='amount in pageOptions', :value='amount') {{ amount }}
  span {{ ((currentPage - 1) * currentSize) + 1 }}-{{ subTotal }} {{ separator }} {{ total }}
  v-button.v-icon-button.v-table-pagination-previous(@click.native='previousPage', :disabled='currentPage === 1')
    v-icon keyboard_arrow_left
  v-button.v-icon-button.v-table-pagination-next(@click.native='nextPage', :disabled='shouldDisable')
    v-icon keyboard_arrow_right
</template>

<script lang="coffee">
component =
  name: 'v-table-pagination'
  props:
    size:
      type: [Number, String]
      default: 10
    pageOptions: [Array, Boolean]
    page:
      type: [Number, String]
      default: 1
    total:
      type: [Number, String]
      default: 'Many'
    label:
      type: String
      default: 'Rows per page'
    separator:
      type: String
      default: 'of'
  data: ->
    subTotal: 0
    totalItems: 0
    currentPage: 1
    currentSize: 0
  watch:
    total: (val) ->
      @totalItems = if isNaN(val) then Number.MAX_SAFE_INTEGER else parseInt(val, 10)
    size: (val) ->
      @currentSize = parseInt(val, 10)
    page: (val) ->
      @currentPage = parseInt(val, 10)
  computed:
    lastPage: ->
      false
    shouldDisable: ->
      @currentSize * @currentPage >= @totalItems
  methods:
    emitPaginationEvent: ->
      if @canFireEvents
        sub = @currentPage * @currentSize
        @subTotal = if sub > @total then @total else sub
        @$emit 'pagination',
          size: @currentSize
          page: @currentPage
    changeSize: ->
      if @canFireEvents
        @$emit 'size', @currentSize
        @emitPaginationEvent()
    previousPage: ->
      if @canFireEvents
        @currentPage--
        @$emit 'page', @currentPage
        @emitPaginationEvent()
    nextPage: ->
      if @canFireEvents
        @currentPage++
        @$emit 'page', @currentPage
        @emitPaginationEvent()
  mounted: ->
    @$nextTick ->
      @subTotal = @currentPage * @currentSize
      @pageOptions = @pageOptions or [10,25,50,100]
      @currentSize = @pageOptions[0]
      @canFireEvents = true

return component
</script>
