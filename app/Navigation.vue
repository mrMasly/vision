<template lang="jade">
v-bottom-bar
  v-bottom-bar-item(
    v-for="tab in tabs" key="tab.name"
    v-bind:v-icon="tab.icon"
    v-bind:v-active="tab.active"
    @click.native="click(tab)") {{tab.title}}

</template>

<script lang="coffee">

import _ from 'lodash'

component =
  name: 'Sidenav'
  data: ->
    tabs: []
  methods:
    # при клике на таб
    click: (tab) ->
      @$router.push tab.route
    # запоминть роут таба
    rememberTabRoute: (route) ->
      return unless route?
      return unless route.name?
      path = route.path
      route = _.find @$router.options.routes, name: route.name
      return unless route.tab?
      tabName = if _.isObject route.tab then route.tab.name else route.tab
      tab = _.find @tabs, name: tabName
      return unless tab?
      tab.route = path: path
    # сделать нужный таб выбранным
    selectTab: (route) ->
      route = _.find @$router.options.routes, name: route.name
      return unless route.tab?
      tabName = if _.isObject route.tab then route.tab.name else route.tab
      for tab in @tabs
        if tab.name is tabName
          tab.active = yes
        else
          tab.active = no

  created: ->

    # получаем все табы
    for route in @$router.options.routes
      if _.isObject(route.tab) and route.module? and route.module.access()
        tab = _.clone route.tab
        tab.active ?= no
        tab.route ?= name: route.name
        @tabs.push tab

    # при смене роута
    @$router.beforeEach (to, from, next) =>
      @rememberTabRoute from
      @selectTab to
      do next

    @selectTab @$route


return component
</script>

<style lang="stylus" scoped>
.sidenav
  width 60px
  flex none
.v-bottom-bar
  z-index 2
  position relative !important
</style>
