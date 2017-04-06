<template lang="jade">
.l-padding.l-25.md-33.sm-50.xs-100
  md-card
    md-card-header
      md-avatar
        md-icon person
      md-card-header-text
        .md-subheading {{group.name}}
        .md-caption {{group._id}}
      md-menu(md-size="4")
        md-button.md-icon-button(md-menu-trigger)
          md-icon more_vert
        md-menu-content
          md-menu-item(@selected="edit")
            md-icon edit
            span Редактировать
          md-menu-item(@selected="remove")
            md-icon delete
            span Удалить
    md-card-content {{group.description}}
</template>

<script lang="coffee">
component =
  module: module
  name: 'group'
  props:
    group: Object
  methods:
    edit: ->
      @$router.push name: 'access', params: id: @group._id, tab: 'groups'
    remove: ->
      @$confirm "Удалить группу #{@group.name}?", =>
        @$call 'removeGroup', @group._id, (err, res) =>
  meteor:
    server: '../server'


return component
</script>

<style lang="stylus" scoped>
.md-card
  height 150px
.md-card-content
  padding-bottom 10px !important
.group:not(:last-child):after
  content: ', '
.md-card-header
  padding 6px !important
.md-subheading
  word-wrap nowrap
</style>
