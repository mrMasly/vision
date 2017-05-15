<template lang="jade">
.l-column.l-fill.l-absolute#vision
  Login(v-if="!userId" @login="login")
  template(v-else-if="$subReady.user")
    Toolbar.no-print
    .l-flex.l-relative
      keep-alive(:include="/-alive/")
        router-view.l-fill.l-absolute#vision-router-view
    Navigation.no-print
    Dialogs
    Toasts
    component(:is="component" v-for="component in dialogs")
</template>

<script lang="coffee">
import Navigation from './Navigation.vue'
import Toolbar from './Toolbar.vue'
import Dialogs from './Dialogs.vue'
import Toasts from './Toasts.vue'
import Login from './Login.vue'
import _ from 'lodash'
module.access = -> yes

component =
  components: { Navigation, Toolbar, Dialogs, Login }
  name: 'Vision'
  root: yes
  head:
    title: 'Vision'
    link: [
      {rel: 'stylesheet', href: '//fonts.googleapis.com/css?family=Roboto:300,400,500,700,400italic'}
      {rel: 'stylesheet', href: '//fonts.googleapis.com/icon?family=Material+Icons'}
      {rel: 'icon', href: '/packages/mrmasly_vision/files/icon.png', type: 'image/png' }
    ]
  data: ->
    name: 'vision'
    userId: Meteor.userId()
    ready: no
    dialogs: null
  meteor:
    server:
      publish:
        user: () ->
          Mongo.Users.find {_id: @userId}, fields: groups: 1
    subscribe:
      user: []
  methods:
    login: -> @userId = Meteor.userId()
  created: ->
    do @login
    @dialogs = _.filter Meteor.Components, dialog: yes
return component
</script>

<style lang="stylus" scoped>
#vision
  width 100%
  height 100%
  overflow hidden
</style>
