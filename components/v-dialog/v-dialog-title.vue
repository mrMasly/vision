<template lang="jade">
.v-dialog-title.md-title
  slot
</template>

<script lang="coffee">
component =
  name: 'v-dialog-title'

return component
</script>

<style lang="stylus">
.v-dialog-title
  display flex
  flex-direction row
  margin-bottom 20px
  padding 24px 24px 0
  justify-content start
  align-items center
  align-content center
</style>
