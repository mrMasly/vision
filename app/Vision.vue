<template lang="jade">
.layout.layout-column.layout-fill#vision
  Toolbar
  .flex
    router-view

  Navigation
  Dialogs
</template>

<script lang="coffee">
import Navigation from './Navigation.vue'
import Toolbar from './Toolbar.vue'
import Dialogs from './Dialogs.vue'

return {
  components: { Navigation, Toolbar, Dialogs }
  name: 'Vision'
  data: ->
    name: 'vision'
}

</script>

<style lang="stylus">
body
.md-layout
  width 100%
  height 100%

.transition
  &.enter
    animation fadeInUp
</style>

<style lang="stylus" scoped>



#vision
  width 100%
  height 100%
  overflow hidden
</style>
