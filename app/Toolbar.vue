<template lang="jade">
md-toolbar
  h1.md-title(v-if="$store.state.tab") {{$store.state.tab.title}}
</template>

<script lang="coffee">
component =
  name: 'Toolbar'

return component
</script>

<style lang="stylus" scoped>
</style>
