<template lang="jade">
div.l-fill.l-row.l-absolute
  Sidenav
  md-divider
  DataTasks.l-flex
  md-divider
  //- template(v-if="$route.params.id")
  .task
    Task(v-if="$route.params.id && $layout.gmd", :id="$route.params.id" @close="close")
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
