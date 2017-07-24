<template lang="jade">
.panel.l-column
  Add
  Groups(:groups="groups")
</template>

<script lang="coffee">
import Add from '../add/Add.vue'
import Groups from '../data/Groups.vue'
component =
  name: 'Panel'
  components: { Add, Groups }
  data: ->
    user = Meteor.userId()
    groups = []
    groups.push name: 'Сделать прямо сейчас', index: -999, match:
      done: no, for: user, just: yes
    groups.push name: 'Новые', index: 1, match:
      done: no, for: user
      parent: $exists: yes
      viewed: no
    return { groups }
    
return component
</script>

<style lang="stylus" scoped>
.panel
  width 500px
  max-width 100%
</style>