<template lang="jade">
.l-padding.l-25.v-33.sm-50.xs-100
  v-card
    v-card-header
      v-avatar
        img(:src="user.photo.xs" v-if="user.photo")
      v-card-header-text
        .v-subheading {{user.profile.name}}
        .v-caption {{user.username}}
      v-menu(size="4" v-if="mounted")
        v-button.v-icon-button(menu-trigger)
          v-icon more_vert
        v-menu-content
          v-menu-item(@selected="edit")
            v-icon edit
            span Редактировать
          v-menu-item(@selected="photo")
            v-icon photo
            span Фото
          v-menu-item(@selected="remove")
            v-icon delete
            span Удалить
    v-card-content
      span.group(v-for="group in groups") {{group.name}}

</template>

<script lang="coffee">


component =
  module: module
  name: 'user'
  data: ->
    mounted: no
  mounted: ->
    @mounted = yes
  methods:
    edit: ->
      @$router.push
        name: 'access'
        params:
          id: @user._id
          tab: 'users'
    remove: ->
      @$confirm "Удалить пользователя #{@user.profile.name}?", =>
        @$call 'removeUser', @user._id, (err, res) =>
    photo: ->
      @$router.push
        name: 'access'
        params:
          id: @user._id
          tab: 'users'
        query:
          photo: null
  meteor:
    server: '../server'
    data:
      groups: -> Mongo.Users.Groups.find _id: $in: @user.groups
  props:
    user:
      type: Object
      required: yes

return component
</script>

<style lang="stylus" scoped>
.v-card
  height 150px
  background-color #fff
.v-card-content
  padding-bottom 10px !important
.group:not(:last-child):after
  content: ', '
.v-card-header
  padding 6px !important
.v-subheading
  word-wrap nowrap
</style>
