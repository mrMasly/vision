<template lang="jade">
v-toolbar.v-shadow-2
  h1.v-title.l-flex {{title}}
  .components.l-row
    component(:is="one" v-for="one in components", :key="one.module.id")
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'Toolbar'
  data: ->
    components = _.filter Meteor.Components, (one) ->
      return no unless one.nav
      return no unless one.module.access()
      return yes
    title: null
    components: components
    
  created: ->
    @getTitle @$route
    @$router.beforeEach (to, from, next) =>
      @getTitle to
      do next
  methods:
    # определяет заголовок по роуту
    getTitle: (route) ->
      route = _.find @$router.options.routes, name: route.name
      @title = route?.title ? null

return component
</script>

<style lang="stylus" scoped>
.v-toolbar
  z-index 2
</style>
