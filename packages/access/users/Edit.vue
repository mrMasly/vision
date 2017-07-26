<template lang="jade">
.l-fill.l-column.user
  v-toolbar
    h2.v-title.l-flex(v-once) {{title || user.profile.name}}
    slot(name="close")
  v-dialog-content.l-flex.overflow

    v-picker(label="Имя пользователя" type="text" v-model="user.username")

    v-picker(label="Имя на русском" type="text" v-model="user.profile.name")

    v-picker(label="Пароль" type="text" v-model="user.password")

    v-picker(label="Группы" type="select" v-model="user.groups" multiple search)
      v-option(:value="group._id" v-for="group in groups", :key="group._id")
        | {{group.name}}
  
  v-dialog-actions
    v-button.v-primary(@click.native="close") Отмена
    v-button.v-primary(@click.native="save") Сохранить
  
  v-progress(indeterminate v-if="saving")
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
    saving: no
  methods:
    close: ->
      @$emit 'close'
    save: ->
      @saving = yes
      @$call 'saveUser', @user, (err, res) =>
        @saving = no
        if err then @$toast err.error
        else do @close
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
