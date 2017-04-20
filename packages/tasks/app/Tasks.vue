<template lang="jade">
div.l-fill.l-row.l-absolute
  Sidenav(v-if="$layout.gsm")
  md-sidenav.md-left.md-fixed(v-else ref="left")
    Sidenav
  md-divider
  DataTasks.l-flex
    md-button.md-icon-button(slot="sidenav-toggle" v-if="!$layout.gsm"
    @click.native="$refs.left.open")
      md-icon menu
  md-divider
  //- template(v-if="$route.params.id")
  .task(v-if="$layout.gmd")
    Task(v-if="$route.params.id", :id="$route.params.id" @close="close")
  md-sidenav.md-right.md-fixed(v-else ref="right")
    Task(v-if="$route.params.id", :id="$route.params.id" @close="close();$refs.right.close()")

</template>

<script lang="coffee">

import Sidenav from './sidenav/Sidenav.vue'
import DataTasks from './data/Data.vue'
import Task from './task/Task.vue'
# import Add from './add/Add.vue'
component =
  name: 'tasks'
  components: { Sidenav, DataTasks, Task }
  methods:
    close: -> @$router.push params: { id: null }
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
