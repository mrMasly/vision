<template lang="jade">
v-toolbar.v-shadow-2
  h1.v-title.l-flex(v-if="$layout.gxs || !show") {{title}}
  .components.l-row(v-if="$layout.gxs")
    component(:is="one" v-for="one in components", :key="one.module.id")
  .absolute.l-row.l-end-center(v-else)
    component(:is="one" v-for="one in components", :key="one.module.id" v-if="show")
    v-button.v-icon-button(@click.native="toggle")
      v-icon menu
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
    
    component.navIndex ?= 0 for component in components
    components = _.sortBy components, 'navIndex'

    title: null
    components: components
    show: no
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
    toggle: ->
      @show = !@show

return component
</script>

<style lang="stylus" scoped>
.v-toolbar
  z-index 2
.absolute
  position absolute
  // background-color #2196f3
  width 100%
  height 100%
  right 0
  top 0
</style>
