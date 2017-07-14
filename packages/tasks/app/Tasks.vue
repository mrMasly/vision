<template lang="jade">
div.l-fill.l-row.l-absolute
  Sidenav(v-if="$layout.gsm")
  v-sidenav(v-else ref="left" fixed)
    Sidenav
  v-divider
  DataTasks.l-flex
    v-button.v-icon-button(slot="sidenav-toggle" v-if="!$layout.gsm"
    @click.native="$refs.left.open")
      v-icon menu
  v-divider
  //- template(v-if="$route.params.id")
  .task(v-if="$layout.gmd && mounted")
    Task(v-if="$route.params.id", :id="$route.params.id" @close="close")
  v-sidenav(v-else-if="mounted" ref="right" fixed right @close="close")
    Task(v-if="$route.params.id", :id="$route.params.id" @close="$refs.right.close()")

</template>

<script lang="coffee">

import Sidenav from './sidenav/Sidenav.vue'
import DataTasks from './data/Data.vue'
import Task from './task/Task.vue'
# import Add from './add/Add.vue'
component =
  name: 'tasks'
  components: { Sidenav, DataTasks, Task }
  data: ->
    mounted: no
  methods:
    close: -> @$router.push params: { id: null }
  created: ->
    if Meteor.isClient
      @$store.state.vision.tasks.user ?= Meteor.userId()
  mounted: ->
    @mounted = yes
    @$nextTick ->
      if @$route.params.id? and @$refs.right?
        @$refs.right.open()
  watch:
    '$route.params.id': (id) ->
      return unless @$refs.right?
      if id then @$refs.right.open()
      else @$refs.right.close()
  route:
    path: '/tasks/:tab?/:id?'
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
