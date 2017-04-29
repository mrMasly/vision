<template lang="jade">
.v-backdrop(@click="close" @keyup.esc="close")
</template>

<script lang="coffee">
component =
  name: 'v-backdrop'
  methods:
    close: -> @$emit 'close'

return component
</script>
