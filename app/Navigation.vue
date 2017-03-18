<template lang="jade">
md-bottom-bar
  md-bottom-bar-item(
    v-for="tab in tabs" key="tab.name"
    v-bind:md-icon="tab.icon"
    v-bind:md-active="tab.active"
    @click.native="click(tab)") {{tab.title}}

</template>

<script lang="coffee">

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
