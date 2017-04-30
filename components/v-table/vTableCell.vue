<template lang="jade">
td.v-table-cell(:class='classes')
  .v-table-cell-container
    slot
</template>

<script lang="coffee">
component =
  name: 'v-table-cell'
  props:
    vNumeric: Boolean
  data: ->
    hasAction: false
  computed:
    classes: ->
      'v-numeric': @vNumeric
      'v-has-action': @hasAction
  mounted: ->
    if @$children.length > 0
      @hasAction = true

return component
</script>
