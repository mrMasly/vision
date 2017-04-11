<template lang="jade">
.l-column
  md-input-container
    label Исполнитель
    md-select(v-model="task.users" multiple)
      md-option(v-for="user in users", :value="user._id") {{user.profile.name}}
</template>

<script lang="coffee">
component =
  name: 'users'
  props:
    task: Object
  created: ->
    @task.users ?= [Meteor.userId()]
  meteor:
    server:
      publish:
        users: -> Mongo.Users.find {}, fields:
          'profile.name': 1
          'username': 1
    subscribe:
      users: []
    data:
      users: -> Mongo.Users.find()
return component
</script>

<style lang="stylus" scoped>
</style>
