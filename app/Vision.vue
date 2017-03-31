<template lang="jade">
.fx-column.fx-fill.fx-absolute#vision
  Login(v-if="!userId" @login="login")
  template(v-else-if="$subReady.user")
    Toolbar
    .fx-flex.fx-relative
      router-view
    Navigation
    Dialogs
    Toasts

</template>

<script lang="coffee">
import Navigation from './Navigation.vue'
import Toolbar from './Toolbar.vue'
import Dialogs from './Dialogs.vue'
import Toasts from './Toasts.vue'
import Login from './Login.vue'

module.access = -> yes

return {
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
  meteor:
    server:
      publish:
        user: () ->
          Mongo.Users.find {_id: @userId}, fields: groups: 1
    subscribe:
      user: []
  methods:
    login: ->
      @userId = Meteor.userId()

  crated: ->
    do @login



}

</script>

<style lang="stylus">
html
body
  width 100%
  height 100%
  overflow hidden
</style>
<style lang="stylus" scoped>
#vision
  width 100%
  height 100%
  overflow hidden
</style>
