<template lang="jade">
.groups
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
  created: ->
    do @update
  watch: groups: -> do @update
  methods:
    update: ->
      for group in @groups
        unless group.size? then @$set group, 'size', 0
        unless group.index? then @$set group, 'index', 0
        unless group.open? then @$set group, 'open', yes
    toggle: (group) ->
      group.open = not group.open

return component
</script>

<style lang="stylus" scoped>
.v-subheader
  cursor pointer
  user-select none
</style>
