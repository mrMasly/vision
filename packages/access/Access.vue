<template lang="jade">
.access
  v-tabs.v-transparent.l-fill.l-absolute(right ref="tabs" route-param="tab")
    v-tab(label="Пользователи" name="users")
      Users
    v-tab(label="Группы" name="groups")
      Groups

  v-dialog.fullscreen(ref="dialog" route-param="id")
    template(v-if="$route.params.id")
      template(v-if="$route.params.tab=='users'")
        PhotoUser(:id="$route.params.id" @close="close" v-if="$route.query.photo===null")
          v-button.v-icon-button(slot="close" @click.native="$refs.dialog.close()")
            v-icon close
        EditUser(:id="$route.params.id" @close="close" v-else)
          v-button.v-icon-button(slot="close" @click.native="$refs.dialog.close()")
            v-icon close

      EditGroup(:id="$route.params.id" v-if="$route.params.tab=='groups'" @close="close")
        v-button.v-icon-button(slot="close" @click.native="$refs.dialog.close()")
          v-icon close
  //-
  v-button.v-fab.v-fab-bottom-right(@click.native="add")
    v-tooltip(direction="left") Создать {{createType}}
    v-icon add

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
    title: 'Доступ'
    tab:
      name: 'access'
      icon: 'verified_user'
      title: 'Доступ'

return component

</script>


<style lang="stylus" scoped>
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
