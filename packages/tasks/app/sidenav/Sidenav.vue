<template lang="jade">
main
  .l-absolute.l-fill.l-column
    v-toolbar.v-transparent.v-shadow.v-dense
      .v-title Поиск
    Groups.l-flex.l-scroll(@select="$emit('select')")
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
  height 100%
  position relative
.v-toolbar
  z-index 2
</style>
