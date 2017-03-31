<template lang="jade">
.fx-padding.fx-25.md-33.sm-50.xs-100
  md-card
    md-card-header
      md-avatar
        img(v-bind:src="user.photo.xs" v-if="user.photo")
      md-card-header-text
        .md-subheading {{user.profile.name}}
        .md-caption {{user.username}}
      md-menu(md-size="4")
        md-button.md-icon-button(md-menu-trigger)
          md-icon more_vert
        md-menu-content
          md-menu-item(@selected="edit")
            md-icon edit
            span Редактировать
          md-menu-item(@selected="photo")
            md-icon photo
            span Фото
          md-menu-item(@selected="remove")
            md-icon delete
            span Удалить
    md-card-content
      span.group(v-for="group in groups") {{group.name}}

</template>

<script lang="coffee">


component =
  module: module
  name: 'user'
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
.md-card
  height 150px
.md-card-content
  padding-bottom 10px !important
.group:not(:last-child):after
  content: ', '
.md-card-header
  padding 6px !important
.md-subheading
  word-wrap nowrap
</style>
