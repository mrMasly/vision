<template lang="jade">
.l-fill.l-column.photo
  md-toolbar.l-row
    h2.md-title.l-flex
      span(v-if="user" v-once) Фото пользователя {{user.profile.name}}
    md-button.md-icon-button(@click.native="close")
      md-icon close
  md-dialog-content.l-flex
    dropzone(url="https://httpbin.org/post" v-on:add="add" v-if="!file")
    croppie(ref="croppie" v-bind:file="file" type="circle" v-else)
  md-dialog-actions
    md-button.md-primary(@click.native="close") Отмена
    md-button.md-primary(@click.native="save") Сохранить


</template>

<script lang="coffee">

component =
  module: module
  name: 'photo'
  props:
    id: String
  data: ->
    img: null
    file: null
  meteor:
    server: '../server'
    data:
      user: -> Mongo.Users.findOne @id
  methods:
    close: -> @$emit 'close'
    save: ->
      @$refs.croppie.get (file) =>
        Mongo.Users.update @user._id, {$set: photo: file}, (err, res) =>
          do @close
    add: (@file) ->
return component
</script>



<style lang="stylus" scoped>
.photo
  width 800px
  max-width 100%
  height 500px
  max-height 100%
.md-dialog-content
  padding 10px
img
  height 100%
</style>
