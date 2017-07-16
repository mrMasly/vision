<template lang="jade">
.l-column
  .v-caption Теги
  v-chips(v-model="task.tags" v-input-name="tags")
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
.v-chips
  position relative
  margin-top -16px
</style>
