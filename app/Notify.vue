<template lang="jade">
div(ref="div")
  v-button.v-icon-button(@click.native="$refs.panel.open()")
    v-icon notifications
    v-badge(v-model="notifys.length")
    v-tooltip Уведомления
  v-panel(ref="panel" align="div" x="end" y="start" alive v-if="mounted")
    v-list.v-dense
      v-list-item.item(v-for="notify in notifys", :key="notify._id" @click.native="openNotify(notify);closeNotify(notify)")
        .v-list-text-container
          span {{notify.title}}
          span {{notify.text}}
        v-button.v-icon-button(@click.native.stop="closeNotify(notify)")
          v-icon close
        v-divider
      v-list-item(v-if="!notifys.length") Уведомлений нет
</template>

<script lang="coffee">
module.access = -> yes
component =
  name: 'Notify'
  nav: yes
  data: ->
    mounted: no
    user: Meteor.userId()
    docs: []
  mounted: ->
    @mounted = yes
  methods:
    openNotify: (notify) ->
      if notify.route?
        @$router.push notify.route
    closeNotify: (notify) ->
      Mongo.Vision.Notify.update notify._id, $set: viewed: yes
    test: (doc) ->
      return unless @mounted
      return if doc._id in @docs
      @docs.push doc._id
      if doc.for is @user and not doc.viewed and doc.alert
        @$toast
          title: doc.title
          text: doc.text
          audio: 'notification'
          cb: =>
            if doc.route?
              @$router.push doc.route
              Mongo.Vision.Notify.update doc._id, $set: viewed: yes
          close: =>
            Mongo.Vision.Notify.update doc._id, $set: viewed: yes

  meteor:
    server:
      publish:
        notifys: ->
          Mongo.Vision.Notify.find
            for: @userId
            viewed: no
    subscribe:
      notifys: []
    notifys: ->
      Mongo.Vision.Notify.find {viewed: no}, transform: (doc) =>
        @test doc
        return doc

return component
</script>

<style lang="stylus" scoped>
.v-list
  width 400px
  max-width 100%
  max-height 100%
  overflow-y auto
.item:last-child
  .v-divider
    display none
</style>