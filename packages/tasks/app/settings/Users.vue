<template lang="jade">
.l-column
  v-input-container
    label Исполнитель
    v-select(v-model="task.users" multiple search)
      v-option(v-for="user in users", :value="user._id") {{user.profile.name}}
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'users'
  data: ->
    search: ''
  props:
    task: Object
  meteor:
    server:
      publish:
        users: -> Mongo.Users.find {}, fields:
          'profile.name': 1
          'username': 1
    subscribe:
      users: []
    data:
      users: -> Mongo.Users.find
        _id: $ne: Meteor.userId()
return component
</script>

<style lang="stylus" scoped>
</style>
