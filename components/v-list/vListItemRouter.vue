<template lang="jade">
li.v-list-item(:class='classes', :disabled='disabled')
  slot
    v-ink-ripple(:disabled='disabled')
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
