<template lang="jade">
v-caption.description(v-if="$store.state.vision.tasks.description")
  div(v-if="$route.params.tab == 'inbox'")
    div Когда Вы хотите создать задачу, но еще не решили когда Вы будете ее выполнять и сколько времени она займет, то ее нужно заносить сюда, во "Входящие".
    div Так же здесь отображаются задачи от других пользователей.
    div Все задачи от других пользователей отображаются в подгруппе "Новые" до тех пор, пока Вы их не откроете. После, эти задачи будут отображаться в подгрупп "От других пользователей".
  div(v-else-if="$route.params.tab == 'today'")
    div Во вкладке "Сегодня" отображаются задачи, которые вы должны выполнить сегодня или ранее.
    div Так же Вы увидите здесь завершенные сегодня задачи.
  div(v-else-if="$route.params.tab == 'week'")
    div Здесь отображаются задачи, которые у Вас запланированы на ближайшие 7 дней.
  div(v-else-if="$route.params.tab == 'wait'")
    div Здесь отображаются все задачи, которые поставили Вы, но выполнить их должны другие пользователи.
  div(v-else-if="$route.params.tab == 'someday'")
    div Здесь отображаются задачи, отложенные на потом.
    div Если вы хотите сохранить задачу, но знаете, что сейчас Вы не будете заниматься ею, то сохраняйте ее сюда, в группу "Когда-нибудь". Позже Вы сможете зайти в эту группу и посмотреть все такие задачи.
  div(v-else-if="$route.params.tab == 'repeat'")
    div Здесь отображаются регулярные (повторяющиеся) задачи, созданные Вами.
  v-icon.icon(@click.native="close") close
v-icon.icon(v-else @click.native="open") info_outline

    
</template>

<script lang="coffee">
component =
  name: 'Description'
  methods:
    close: ->
      @$store.state.vision.tasks.description = no
    open: ->
      @$store.state.vision.tasks.description = yes

return component
</script>

<style lang="stylus" scoped>
.description
  padding 20px
  position relative
.icon
  position absolute
  top 10px
  right 10px
  opacity .5
  z-index 2
  cursor pointer
</style>