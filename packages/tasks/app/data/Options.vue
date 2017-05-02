<template lang="jade">
.l-row.l-end.l-padding
  v-button.v-primary.v-icon-button(
    v-for="option in options",
    :class="[{active: ($store.state.vision.tasks.options.indexOf(option.name)+1)}]",
    @click.native="toggle(option)")
    v-icon {{option.icon}}
</template>

<script lang="coffee">
component =
  name: 'options'
  data: ->
    options: [
      {name: 'tags', icon: 'style', title: 'Показывать теги'}
      {name: 'subs', icon: 'view_comfy', title: 'Показывать подзадачи отдельно'}
      {name: 'priority', icon: 'report_problem', title: 'Выделить важные'}
      {name: 'users', icon: 'people', title: 'От других пользователей отдельно'}
      {name: 'group', icon: 'dns', title: 'Разделение по группам'}
    ]
  methods:
    toggle: (option) ->
      @$store.commit 'vision/tasks/toggleOption', option.name
return component
</script>

<style lang="stylus" scoped>
.v-button
  opacity .3
  &.active
    opacity 1
</style>
