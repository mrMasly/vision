<template lang="jade">
.v-card-header-text
  slot
</template>

<script lang="coffee">
component =
  name: 'v-card-header-text'
  mounted: ->
    @parentClasses = @$parent.$el.classList
    if @parentClasses.contains('v-card-header')
      @insideParent = true
      @parentClasses.add 'v-card-header-flex'
  destroyed: ->
    @parentClasses.remove 'v-card-header-flex'

return component
</script>

<style lang="stylus" scoped>
</style>
