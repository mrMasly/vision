<template lang="jade">
li.v-list-item(:class='classes')
  .v-list-item-container.v-button
    slot
  v-button.v-button-ghost(type='button', :disabled='disabled')
</template>

<script lang="coffee">
component =
  name: 'v-list-item'
  props:
    disabled: Boolean
  computed:
    classes: ->
      'v-disabled': @disabled

return component
</script>
