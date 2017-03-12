<template lang="jade">
.layout-fill.relative
  md-tabs.md-transparent.layout-fill.absolute(md-right ref="tabs")
    md-tab(md-label="Пользователи")
      Users
    md-tab(md-label="Группы")
      Groups

  md-dialog.fullscreen(ref="dialog")
    template(v-if="$route.params.id")
      template(v-if="$route.params.tab=='users'")
        PhotoUser(v-bind:id="$route.params.id" @close="close" v-if="$route.query.photo===null")
        EditUser(v-bind:id="$route.params.id" @close="close" v-else)

      EditGroup(v-bind:id="$route.params.id" v-if="$route.params.tab=='groups'" @close="close")

  md-button.md-fab.md-fab-bottom-right(@click.native="add")
    md-tooltip(md-direction="left") Создать {{createType}}
    md-icon add

</template>

<script lang="coffee">

import Users from './users/Users.vue'
import Groups from './groups/Groups.vue'
import EditUser from './users/Edit.vue'
import EditGroup from './groups/Edit.vue'
import PhotoUser from './users/Photo.vue'

component =
  module: module
  name: 'Access'
  components: { Users, Groups, EditUser, EditGroup, PhotoUser }
  data: ->
    search: 'access/user'
  methods:
    close: ->
      @$route.params.id = null
      @$router.push
        name: @$route.name
        params: tab: @$route.params.tab
    add: ->
      @$router.push
        name: @$route.name
        params:
          tab: @$route.params.tab
          id: 'new'
  computed:
    createType: -> if @$route.params.tab is 'users' then 'пользователя' else 'группу'
  route:
    path: '/access/:tab?/:id?'
    name: 'access'
    tab:
      name: 'access'
      icon: 'verified_user'
      title: 'access'
    params:
      tab:
        type: 'tabs'
        ref: 'tabs'
        data: ['users', 'groups']
        default: 'users'
      id:
        type: 'dialog'
        ref: 'dialog'

return component

</script>


<style lang="stylus" scoped>
.access
  position relative
.search
  position absolute
  top 3px
  display block
  width 300px
  height 40px
  line-height 40px
  min-height 40px
  z-index 999
  padding 0 30px
</style>
