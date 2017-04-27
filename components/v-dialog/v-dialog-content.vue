<template lang="jade">
.v-dialog-content
  slot
</template>

<script lang="coffee">
component =
  name: 'v-dialog-content'

return component
</script>

<style lang="stylus">
.v-dialog-content
  padding 0 24px 24px
  flex 1
  flex-basis auto
  overflow auto
  position relative
  background: linear-gradient(to bottom, #fff 0, #fff 1px, transparent 1px),
              linear-gradient(to top, #fff 0, #fff 3px, transparent 3px),
              linear-gradient(to bottom, rgba(#000, .12) 0, rgba(#000, .12) 1px, transparent 1px),
              linear-gradient(to top, rgba(#000, .2) 1px, rgba(#000, .2) 2px, transparent 2px);
  background-attachment local, local, scroll, scroll
  &:first-child
    padding-top: 24px;
  p:first-child:not(:only-child)
    margin-top: 0;
  p:last-child:not(:only-child)
    margin-bottom: 0;
</style>
