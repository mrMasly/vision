<template lang="jade">
.l-fill.l-column.l-center-center(ref="div")
  md-card
    md-card-header
      .md-title Войдите
    md-card-content
      md-input-container
        label Имя
        md-input(v-model="username")
      md-input-container(md-has-password v-bind:class="{ 'md-input-invalid': error }")
        label Пароль
        md-input(type="password" v-model="password" @change="error=''")
        .md-error(v-if="error") {{error}}
    md-card-actions
      md-button.md-primary(@click.native="login") Войти

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
.md-card
  width 300px
</style>
