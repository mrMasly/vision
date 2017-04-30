<template lang="jade">
.v-card-area(:class="classes")
  slot
</template>

<script lang="coffee">
component =
  name: 'v-card-area'
  props:
    inset: [Boolean, String]
  computed:
    classes: ->
      'v-inset': @inset

return component
</script>
