<template lang="jade">
.v-badge(v-if="value") {{ (value>99) ? '99+' : value }}
</template>

<script lang="coffee">
component =
  name: 'vBadge'
  props:
    value: Number

return component
</script>

<style lang="stylus" scoped>
</style>