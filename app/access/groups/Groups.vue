<template lang="jade">
.fx-fill.fx-row.fx-wrap
  Group(v-for="group in groups" v-bind:group="group")
</template>

<script lang="coffee">
import Group from './Group.vue'

component =
  module: module
  components: { Group }
  data: ->
    groups: []
  name: 'groups'
  meteor:
    server: '../server'
    subscribe:
      groups: []
    data:
      groups: -> Mongo.Users.Groups.find()

return component
</script>

<style lang="stylus" scoped>
</style>
