<template lang="jade">
.v-dialog-actions
  slot
</template>

<script lang="coffee">
component =
  name: 'v-dialog-actions'

return component
</script>

<style lang="stylus">
.v-dialog-actions
  min-height 52px
  padding 8px 8px 8px 24px
  display flex
  align-items center
  justify-content flex-end
  position relative
  &:before
    height 1px
    position absolute
    top -1px
    right 0
    left 0
    background-color #fff
    content " "
  .md-button
    min-width 64px
    margin 0
    padding 0 8px
    + .md-button
      margin-left 8px
</style>
