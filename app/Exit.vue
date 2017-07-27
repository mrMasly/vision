<template lang="jade">
v-button.v-icon-button(@click.native="exit")
  v-icon exit_to_app
  v-tooltip Выйти
</template>

<script lang="coffee">
module.access = -> yes
component =
  name: 'Exit'
  nav: yes
  navIndex: 999
  methods:
    exit: ->
      @$confirm 'Вы уверены, что хотите выйти из текущего пользователя?', =>
        Meteor.logout =>
          window.location.reload()

return component
</script>
