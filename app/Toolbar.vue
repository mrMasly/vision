<template lang="jade">
v-toolbar.v-shadow-2
  h1.v-title {{title}}
</template>

<script lang="coffee">

import _ from 'lodash'

component =
  name: 'Toolbar'
  data: ->
    title: null
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
