<template lang="jade">
md-bottom-bar
  md-bottom-bar-item(
    v-for="tab in $store.state.tabs" key="tab.name"
    v-bind:md-icon="tab.icon"
    v-bind:md-active="tab.active"
    @click.native="click(tab)") {{tab.title}}

</template>

<script lang="coffee">

component =
  name: 'Sidenav'
  data: ->
    name: '123'
    name2: 'side'
  methods:
    click: (tab) ->
      # console.log tab.route
      @$router.push tab.route
  created: ->
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
