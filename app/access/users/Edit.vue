<template lang="jade">
.fx-fill.fx-column.user
  md-toolbar
    h2.md-title.fx-flex(v-once) {{title || user.profile.name}}
    md-button.md-icon-button(@click.native="close")
      md-icon close
  md-dialog-content.flex.overflow
    md-input-container
      label Имя пользователя
      md-input(type="text" v-model="user.username")
    md-input-container
      label Имя на русском
      md-input(type="text" v-model="user.profile.name")
    md-input-container
      label Пароль
      md-input(type="text" v-model="user.password")
    md-input-container
      label Группы
      md-select(v-model="user.groups" multiple)
        md-option(v-bind:value="group._id" v-for="group in groups") {{group.name}}
  md-dialog-actions
    md-button.md-primary(@click.native="close") Отмена
    md-button.md-primary(@click.native="save") Сохранить

</template>


<script lang="coffee">

component =
  module: module
  name: 'edit'
  created: ->
    if @id is 'new'
      @user =
        profile: name: ''
        username: ''
        groups: []
      @title = 'Новый пользователь'
  props:
    id: String
  data: ->
    user: profile: null
    groups: []
    title: null
  methods:
    close: ->
      @$emit 'close'
    save: ->
      @$call 'saveUser', @user, (err, res) =>
        unless err then do @close
  meteor:
    server: '../server'
    subscribe:
      user: -> [@id]
      groups: []
    data:
      user: -> Mongo.Users.findOne @id
      groups: -> Mongo.Users.Groups.find()

return component
</script>

<style lang="stylus">
@media (max-width: 600px)
  .md-dialog
    max-width 100%
    max-height 100%
  .fullscreen > .md-dialog
    width 100%
    height 100%
</style>

<style lang="stylus" scoped>
.user
  width 700px
</style>
