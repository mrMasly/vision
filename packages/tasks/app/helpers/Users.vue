<template lang="jade">
.users(v-if="users")
  .user(v-for="user in users")
    v-tooltip {{user.profile.name}}
    v-avatar.v-shadow
      img(v-if="user.photo && user.photo.xs", :src="user.photo.xs")
    
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'Users'
  props:
    task: Object
  meteor:
    users:
      params: ->
        if @task.from then return [@task.from]
        else if @task.users.length then return @task.users
        else return null
      update: (ids) ->
        return null unless ids?
        if _.isEmpty ids then return []
        Meteor.users.find _id: $in: ids


return component
</script>

<style lang="stylus" scoped>
.v-avatar
  background-color #fff
  min-width 24px !important
  min-height 24px !important
  width 24px !important
  height 24px !important
  img
    width 100%
    height 100%
.users
  white-space nowrap
  margin-left 4px
  margin-right 4px
.user
  display inline-block
  margin-left -8px
  &:first-child
    margin-left 0

</style>