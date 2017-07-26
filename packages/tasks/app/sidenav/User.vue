<template lang="jade">
.l-padding(v-if="control")
  v-input-container
    label Пользователь
    v-select(v-model="$store.state.vision.tasks.user" search)
      v-option(v-for="user in users", :value="user._id", :key="user._id")
        | {{user.profile.name}}

</template>

<script lang="coffee">
module.allow = 
  groups: [ 'control' ]
import _ from 'lodash'
component =
  name: 'user'
  methods:
    customLabel: (data) -> data.profile.name
  data: ->
    userId: Meteor.userId()
  computed:
    control: ->
      if @user?.groups?
        if 'control' in @user.groups
          return yes
      return no
  created: ->
    @$store.state.vision.tasks.user = @userId
  meteor:
    server:
      publish:
        users: -> Mongo.Users.find {}, fields:
          'username': 1
          'profile.name': 1
    subscribe:
      users: []
    users: -> Mongo.Users.find()
    user: -> Meteor.user()
return component
</script>

<style lang="stylus" scoped>
.search
  display block
</style>
