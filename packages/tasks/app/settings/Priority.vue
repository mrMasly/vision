<template lang="jade">
.l-column
  .md-caption Приоритет
  .l-row.l-center
    md-button.l-25.md-raised(
    v-for="type in types",
    :class="[{'md-primary': task.priority === type.value}]",
    @click.native="task.priority = type.value")
      md-icon(:style="{color: type.color}") priority_high
      md-tooltip {{type.name}}
</template>

<script lang="coffee">
component =
  name: 'priority'
  props:
    task: Object
  data: ->
    types: [
      { name: 'обычный', value: 1, color: '#000' }
      { name: 'низкий',  value: 0, color: '#0f0' }
      { name: 'средний', value: 2, color: '#e4b900' }
      { name: 'высокий', value: 3, color: '#f00' }
    ]
return component
</script>

<style lang="stylus" scoped>
.md-button
  min-width 40px
</style>
