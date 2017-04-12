<template lang="jade">
.l-column
  .md-caption Теги
  md-chips(v-model="task.tags" md-input-name="tags")
    template(scope="tag") {{tag.value}}
</template>

<script lang="coffee">
component =
  name: 'tags'
  props:
    task: Object

return component
</script>

<style lang="stylus" scoped>
.md-chips
  position relative
  margin-top -16px
</style>
