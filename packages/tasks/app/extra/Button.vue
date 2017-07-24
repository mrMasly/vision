<template lang="jade">
div(ref="div")
  v-button.v-icon-button(@click.native="open")
    v-icon playlist_add
    v-tooltip(direction="bottom") Создать задачу
    v-badge(:value="newTasks")
  v-panel(ref="panel" align="div" x="end" y="start" alive)
    Panel(@close="$refs.panel.close()" ref="panell")
</template>

<script lang="coffee">
import Panel from './Panel.vue'
component =
  name: 'ToolbarButton'
  components: { Panel }
  nav: yes
  data: ->
    user: Meteor.userId()
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