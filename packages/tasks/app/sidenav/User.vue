<template lang="jade">
.l-padding
  md-input-container
    label Пользователь
    md-select(v-model="user")
      md-select-search(v-model="search")
      md-option(v-for="user in users", :value="user._id") {{user.profile.name}}

</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'user'
  methods:
    customLabel: (data) -> data.profile.name

  data: ->
    user: Meteor.userId()
    search: ''
  computed:
    users: ->
      _.filter @_users, (user) => user.profile.name.toLowerCase().indexOf(@search.toLowerCase())+1
  meteor:
    server:
      publish:
        users: -> Mongo.Users.find {}, fields:
          'username': 1
          'profile.name': 1
    subscribe:
      users: []
    data:
      _users: -> Mongo.Users.find()
return component
</script>

<style lang="stylus" scoped>
.search
  display block
</style>
