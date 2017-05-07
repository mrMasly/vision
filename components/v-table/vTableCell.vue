<template lang="jade">
td.v-table-cell(:class='classes', :style="style")
  .v-table-cell-container
    slot
</template>

<script lang="coffee">
component =
  name: 'v-table-cell'
  props:
    numeric: Boolean
    width: [Number, String]
  data: ->
    hasAction: false
  computed:
    style: ->
      if @width
        width: @width+'px'
    classes: ->
      'v-numeric': @numeric
      'v-has-action': @hasAction
  mounted: ->
    if @$children.length > 0
      @hasAction = true

return component
</script>
