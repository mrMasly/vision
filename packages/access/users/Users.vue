<template lang="jade">
.l-fill.l-row.l-wrap(v-if="ready")
  User(v-for="user in users", :user="user", :groups="groups")
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
