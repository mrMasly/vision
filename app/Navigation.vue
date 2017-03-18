<template lang="jade">
md-bottom-bar
  md-bottom-bar-item(
    v-for="tab in tabs" key="tab.name"
    v-bind:md-icon="tab.icon"
    v-bind:md-active="tab.active"
    @click.native="click(tab)") {{tab.title}}

</template>

<script lang="coffee">

import _ from 'lodash'

component =
  name: 'Sidenav'
  data: ->
    tabs: []
  methods:
    click: (tab) ->
      @$router.push tab.route
  created: ->
    for tab in @$store.state.tabs
      Meteor.registerModule tab.module
      @tabs.push tab if tab.module.access()
      
    @$router.beforeEach (to, from, next) =>

      # проверям доступность нового адреаса
      nextRoute = _.find @$store.state.routes, name: to.name
      module = nextRoute?.component?.module
      if module? and module.access?
        if module.access() is no
          # дуступ закрыт
          return @$router.push path: from.path

      @$store.commit 'selectTab', to
      @$store.commit 'rememberTab', from
      do next
    @$store.commit 'selectTab', @$route


return component
</script>

<style lang="stylus" scoped>
.sidenav
  width 60px
  flex none
</style>
