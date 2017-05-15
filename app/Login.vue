<template lang="jade">
.l-fill.l-column.l-center-center(ref="div")
  v-card
    v-card-header
      .v-title Войдите
    v-card-content
      v-input-container
        label Имя
        v-input(v-model="username" @keydown.native.enter="login")
      v-input-container(has-password, :class="{ 'v-input-invalid': error }")
        label Пароль
        v-input(type="password" v-model="password" @change="error=''"
          @keydown.native.enter="login")
        .v-error(v-if="error") {{error}}
    v-card-actions
      v-button.v-primary(@click.native="login") Войти

</template>

<script lang="coffee">
component =
  module: module
  name: 'login'
  data: ->
    username: ''
    password: ''
    error: ''
  methods:
    login: ->
      Meteor.loginWithPassword @username, @password, (err, res) =>
        @password = ''
        if err then @error = "Неверное имя пользователя или пароль"
        else @$emit 'login'



return component
</script>

<style lang="stylus" scoped>
.v-card
  width 300px
</style>
