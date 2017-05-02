<template lang="jade">
main.l-hidden.l-column
  v-toolbar.v-transparent.v-whiteframe-1dp.v-dense
    .v-title Поиск
  Groups.l-flex
  User


</template>

<script lang="coffee">
import User from './User.vue'
import Groups from './Groups.vue'
component =
  name: 'sidenav'
  components: { User, Groups }

return component
</script>

<style lang="stylus" scoped>
main
  width 270px
.v-toolbar
  z-index 2
</style>
