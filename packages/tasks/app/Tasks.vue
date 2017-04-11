<template lang="jade">
div.l-fill.l-row.l-absolute
  Sidenav
  md-divider
  DataTasks.l-flex

</template>

<script lang="coffee">

import Sidenav from './sidenav/Sidenav.vue'
import DataTasks from './data/Data.vue'
# import Add from './add/Add.vue'
component =
  name: 'tasks'
  components: { Sidenav, DataTasks }
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
</style>
