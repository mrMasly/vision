<template lang="jade">
.l-padding
  v-input-container
    label Пользователь
    v-select(v-model="$store.state.vision.tasks.user" search)
      v-option(v-for="user in users", :value="user._id", :key="user._id")
        | {{user.profile.name}}

</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'user'
  methods:
    customLabel: (data) -> data.profile.name
  data: ->
    user: Meteor.userId()
  meteor:
    created: ->
      @$store.state.vision.tasks.user = @user
    server:
      publish:
        users: -> Mongo.Users.find {}, fields:
          'username': 1
          'profile.name': 1
    subscribe:
      users: []
    data:
      users: -> Mongo.Users.find()
return component
</script>

<style lang="stylus" scoped>
.search
  display block
</style>
