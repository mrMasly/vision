<template lang="jade">
.l-column
  v-input-container
    label Исполнитель
    v-select(v-model="task.users" multiple='')
      v-select-search(v-model="search")
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
  computed:
    users: ->
      _.filter @_users, (i) =>
        i.profile.name.toLowerCase().indexOf(@search.toLowerCase())+1
  meteor:
    server:
      publish:
        users: -> Mongo.Users.find {}, fields:
          'profile.name': 1
          'username': 1
    subscribe:
      users: []
    data:
      _users: -> Mongo.Users.find()
return component
</script>

<style lang="stylus" scoped>
</style>
