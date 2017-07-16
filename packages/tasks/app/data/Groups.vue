<template lang="jade">
div.l-scroll
  div(v-for="group in groups" v-show="group.size > 0")
    v-subheader.has-ripple.v-primary.l-relative(@click.native="toggle(group)")
      v-icon(v-if="group.open") arrow_drop_down
      v-icon(v-else) arrow_drop_up
      v-ripple
      .l-flex.l-relative
        span {{group.name}} ({{group.size}})
    Group(:group="group" v-show="group.open")
</template>

<script lang="coffee">
import Group from './Group.vue'
component =
  name: 'Groups'
  components: { Group }
  props:
    groups: Array
  methods:
    toggle: (group) ->
      group.open = not group.open

return component
</script>

<style lang="stylus" scoped>
.v-subheader
  cursor pointer
  user-select none
</style>
