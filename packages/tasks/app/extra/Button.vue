<template lang="jade">
div(ref="div")
  v-button.v-icon-button(@click.native="open")
    v-icon playlist_add
    v-tooltip(direction="bottom") Создать задачу
    v-badge(:value="newTasks")
  v-panel(ref="panel" align="div" x="end" y="start" alive)
    Panel(@close="$refs.panel.close()" ref="panell" v-if="mounted")
</template>

<script lang="coffee">
import Panel from './Panel.vue'
component =
  name: 'ToolbarButton'
  components: { Panel }
  data: ->
    mounted: no
    user: Meteor.userId()
  mounted: ->
    @mounted = yes
  nav: yes
  methods:
    open: ->
      @$refs.panel.open()
      @$nextTick ->
        $(@$refs.panell.$el).find('input').first().focus()
  meteor:
    newTasks: ->
      Mongo.Tasks.find
        viewed: no
        for: @user
      .count()

return component
</script>