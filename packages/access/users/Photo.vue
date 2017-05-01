<template lang="jade">
.l-fill.l-column.photo
  v-toolbar.l-row
    .v-title.l-flex Фото пользователя {{user.profile.name}}
    //- h2.v-title.l-flex
    //-   span(v-if="user" v-once) Фото пользователя {{user.profile.name}}
    slot(name="close")
  v-dialog-content.l-flex
    .l-absolute.content
      dropzone(url="https://httpbin.org/post" @add="add" v-if="!file")
      croppie(ref="croppie", :file="file" type="circle" v-else)
  v-dialog-actions
    v-button.v-primary(@click.native="close") Отмена
    v-button.v-primary(@click.native="save") Сохранить


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
.v-dialog-content
  padding 10px
img
  height 100%
.content
  width calc(100% - 20px)
  height calc(100% - 20px)
</style>
