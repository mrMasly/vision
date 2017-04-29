<template lang="jade">
.v-card-area(:class="classes")
  slot
</template>

<script lang="coffee">
component =
  name: 'v-card-area'
  props:
    vInset: [Boolean, String]
  computed:
    classes: ->
      'v-inset': @vInset

return component
</script>
