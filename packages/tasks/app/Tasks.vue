<template lang="jade">
div.l-fill.l-row.l-absolute
  Sidenav
  md-divider
  .l-flex 123

</template>

<script lang="coffee">

import Sidenav from './sidenav/Sidenav.vue'
component =
  name: 'tasks'
  components: { Sidenav }
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
