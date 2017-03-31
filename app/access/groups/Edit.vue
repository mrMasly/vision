<template lang="jade">
.fx-fill.fx-column.user
  md-toolbar
    h2.md-title.fx-flex(v-once) {{title || group.name}}
    md-button.md-icon-button(@click.native="close")
      md-icon close
  md-dialog-content.flex.overflow
    md-input-container
      label id группы
      md-input(type="text" v-model="group._id" v-bind:disabled="id!=='new'")
    md-input-container
      label Название группы
      md-input(type="text" v-model="group.name")
    md-input-container
      label Описание
      md-textarea(v-model="group.description")
  md-dialog-actions
    md-button.md-primary(@click.native="close") Отмена
    md-button.md-primary(@click.native="save") Сохранить

</template>


<script lang="coffee">

component =
  module: module
  name: 'edit'
  props:
    id: String
  created: ->
    if @id is 'new'
      @group = {}
      @title = 'Новая группа'
  data: ->
    group: {}
    title: null
  meteor:
    from: '../server'
    module: module
  methods:
    close: ->
      @$emit 'close'
    save: ->
      @$call 'saveGroup', @group, (err, res) =>
        do @close
  meteor:
    server: '../server'
    subscribe:
      group: -> [@id]
    data:
      group: -> Mongo.Users.Groups.findOne(@id)

return component
</script>

<style lang="stylus" scoped>
.user
  width 700px
</style>
