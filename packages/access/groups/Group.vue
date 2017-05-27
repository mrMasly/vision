<template lang="jade">
.l-padding.l-25.l-33.sm-50.xs-100
  v-card
    v-card-header
      v-avatar
        v-icon person
      v-card-header-text
        .v-subheading {{group.name}}
        .v-caption {{group._id}}
      v-menu(size="4" v-if="mounted")
        v-button.v-icon-button(menu-trigger)
          v-icon more_vert
        v-menu-content
          v-menu-item(@selected="edit")
            v-icon edit
            span Редактировать
          v-menu-item(@selected="remove")
            v-icon delete
            span Удалить
    v-card-content {{group.description}}
</template>

<script lang="coffee">
component =
  module: module
  name: 'group'
  props:
    group: Object
  data: ->
    mounted: no
  methods:
    edit: ->
      @$router.push name: 'access', params: id: @group._id, tab: 'groups'
    remove: ->
      @$confirm "Удалить группу #{@group.name}?", =>
        @$call 'removeGroup', @group._id, (err, res) =>
  mounted: ->
    @mounted = yes
  meteor:
    server: '../server'


return component
</script>

<style lang="stylus" scoped>
.v-card
  height 150px
  background-color #fff
.v-card-content
  padding-bottom 10px !important
.group:not(:last-child):after
  content: ', '
.v-card-header
  padding 6px !important
.v-subheading
  word-wrap nowrap
</style>
