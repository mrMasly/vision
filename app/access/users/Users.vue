<template lang="jade">
.layout-fill.layout-row.layout-wrap(v-if="ready")
  User(v-for="user in users" v-bind:user="user" v-bind:groups="groups")
</template>

<script lang="coffee">
import User from './User.vue'
import _ from 'lodash'

component =
  module: module
  components: { User }
  name: 'Users'
  data: ->
    users: []
    groups: {}
  computed:
    ready: -> @$subReady['users'] and @$subReady['groups']
  meteor:
    server: '../server'
    subscribe:
      users: []
      groups: []
    data:
      users: -> Mongo.Users.find()

return component
</script>

<style lang="stylus">

</style>
