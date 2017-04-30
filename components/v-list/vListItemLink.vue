<template lang="jade">
li.v-list-item(:class='classes')
  a.v-list-item-container.v-button(:href='href', :target='target', :disabled='disabled')
    slot
  v-ripple(:disabled='disabled')
</template>

<script lang="coffee">
component =
  name: 'v-list-item'
  props:
    href: String
    target: String
    disabled: Boolean
  computed:
    classes: ->
      'v-disabled': @disabled

return component
</script>
