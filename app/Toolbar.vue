<template lang="jade">
md-toolbar.md-whiteframe.md-whiteframe-4dp
  h1.md-title {{title}}
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
.md-toolbar
  z-index 2
</style>
