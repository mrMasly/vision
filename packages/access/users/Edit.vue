<template lang="jade">
.l-fill.l-column.user
  v-toolbar
    h2.v-title.l-flex(v-once) {{title || user.profile.name}}
    slot(name="close")
  v-dialog-content.l-flex.overflow
    v-input-container
      label Имя пользователя
      v-input(type="text" v-model="user.username")
    v-input-container
      label Имя на русском
      v-input(type="text" v-model="user.profile.name")
    v-input-container
      label Пароль
      v-input(type="text" v-model="user.password")
    v-select(v-model="user.groups" multiple search label="Группы")
      v-option(:value="group._id" v-for="group in groups", :key="group._id") {{group.name}}
  v-dialog-actions
    v-button.v-primary(@click.native="close") Отмена
    v-button.v-primary(@click.native="save") Сохранить

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

<style lang="stylus" scoped>
.user
  width 700px
  max-width 100%
</style>
