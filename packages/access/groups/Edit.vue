<template lang="jade">
.l-fill.l-column.group
  v-toolbar
    h2.v-title.l-flex(v-once) {{title || group.name}}
    slot(name="close")
  v-dialog-content.l-flex.overflow

    v-picker(label="id группы" type="text" v-model="group._id", :disabled="id!=='new'")

    v-picker(label="Название группы" type="text" v-model="group.name")

    v-picker(label="Описание" type="text" v-model="group.description")
    
  v-dialog-actions
    v-button.v-primary(@click.native="close") Отмена
    v-button.v-primary(@click.native="save") Сохранить

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
.group
  width 700px
  max-width 100%
</style>
