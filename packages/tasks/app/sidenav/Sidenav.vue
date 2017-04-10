<template lang="jade">
main.l-hidden.l-column
  md-toolbar.md-transparent.md-whiteframe-1dp.md-dense
    .md-title Поиск
  Groups.l-flex
  User


</template>

<script lang="coffee">
import User from './User.vue'
import Groups from './Groups.vue'
component =
  name: 'sidenav'
  components: { User, Groups }
  created: ->
    unless @$route.params.tab?
      @$router.push params: tab: 'today'

return component
</script>

<style lang="stylus" scoped>
main
  width 270px
.md-toolbar
  z-index 2



</style>
