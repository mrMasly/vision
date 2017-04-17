<template lang="jade">
md-list
  md-list-item.has-ripple(v-for="group in groups"
  @click.native="select(group)",
  :class="[($route.params.tab === group.name) ? 'active': '']")
    md-ink-ripple
    md-icon {{group.icon}}
    span {{group.title}}
    md-divider
</template>

<script lang="coffee">
component =
  name: 'groups'
  data: ->
    groups: [
      {icon: 'inbox', title: 'Входящие', name: 'inbox'}
      {icon: 'today', title: 'Сегодня', name: 'today'}
      {icon: 'filter_7', title: 'Следующие 7 дней', name: 'week'}
      {icon: 'date_range', title: 'Месяц', name: 'month'}
      {icon: 'cloud', title: 'Когда-нибудь', name: 'someday'}
      {icon: 'perm_contact_calendar', title: 'Ожидание', name: 'wait'}
      {icon: 'repeat', title: 'Повторяющиеся', name: 'repeat'}
      {icon: 'check_box', title: 'Выполненные', name: 'done'}
    ]
  created: ->
    unless @$route.params.tab?
      @$router.push params: tab: 'today'
    else
      @$store.commit 'vision/tasks/setGroup', @$route.params.tab
  methods:
    select: (group) ->
      @$store.commit 'vision/tasks/setGroup', group.name
      @$router.push params: tab: group.name

return component
</script>

<style lang="stylus" scoped>
.md-list-item
  &:last-child
    .md-divider
      display none
  &.active
    color #03a9f4 !important
    background-color rgba(2,168,244,0.1) !important
    .md-icon
      color #03a9f4 !important
</style>
