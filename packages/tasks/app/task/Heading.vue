<template lang="jade">
.l-column.l-padding
  .v-caption Заголовок
  textarea(v-model="task.title" ref="title")
  .v-caption Описание
  textarea(v-model="task.description" ref="description" rows="1")

</template>

<script lang="coffee">
import autosize from 'autosize'
component =
  name: 'heading'
  props:
    task: Object
  mounted: -> @$nextTick ->
    autosize @$refs.title
    autosize @$refs.description
  beforeDestroy: ->
    autosize.destroy @$refs.title
    autosize.destroy @$refs.description

return component
</script>

<style lang="stylus" scoped>
textarea
  font-size 16px
  resize none
  border none
  width 100%
  display block
  outline none
  box-shadow none
</style>
