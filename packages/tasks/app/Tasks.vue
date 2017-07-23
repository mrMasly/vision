<template lang="jade">
div.l-fill.l-row.l-absolute
  v-sidenav(ref="left" fixed, :block="$layout.gsm")
    Sidenav(@select="$refs.left.close()")
  v-divider
  DataTasks.l-flex
    v-button.v-icon-button(slot="sidenav-toggle" v-if="!$layout.gsm"
    @click.native="$refs.left.open()")
      v-icon menu
  v-divider
  v-sidenav(v-if="mounted" ref="right" fixed right @close="close", :block="$layout.gmd")
    Task(:id="$route.query.task" @close="$refs.right.close()")

</template>

<script lang="coffee">
import Sidenav from './sidenav/Sidenav.vue'
import DataTasks from './data/Data.vue'
import Task from './Task.vue'
component =
  name: 'tasks'
  components: { Sidenav, DataTasks, Task }
  data: ->
    mounted: no
  methods:
    close: -> @$router.push query: {}
  created: ->
    if Meteor.isClient
      @$store.state.vision.tasks.user ?= Meteor.userId()
  mounted: ->
    @mounted = yes
    @$nextTick ->
      if @$route.query.task? and @$refs.right?
        @$refs.right.open()
  watch:
    '$route.query.task': (id) ->
      return unless @$refs.right?
      if id then @$refs.right.open()
      else @$refs.right.close()
  meteor:
    server:
      publish:
        users: -> Meteor.users.find {}, fields: username: 1, "profile.name": 1, "photo": 1
    subscribe:
      users: []
  route:
    path: '/tasks/:tab?'
    name: 'tasks'
    title: 'Задачи'
    tab:
      name: 'tasks'
      icon: 'format_list_numbered'
      title: 'Задачи'
return component
</script>

<style lang="stylus" scoped>
.task
  width 350px
</style>
