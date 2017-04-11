<template lang="jade">
main.l-row.l-fill
  input.l-flex(placeholder="Добавить задачу")
  Settings.settings

</template>

<script lang="coffee">
import Settings from '../settings/Settings.vue'
component =
  name: 'add'
  components: { Settings }

return component
</script>

<style lang="stylus" scoped>
main
  height 48px
input
  height 100%
  font-size 16px
  border none
  outline none
  box-shadow none
.md-speed-dial
  position relative
  top 5px
.settings
  position absolute
  top 48px
  right 0
</style>
