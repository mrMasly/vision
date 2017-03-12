<template lang="jade">
.layout-fill.layout-column.photo
  md-toolbar
    h2.md-title(v-once) 123
    .flex
    md-button.md-icon-button(@click.native="close")
      md-icon close
  md-dialog-content.flex
    dropzone(url="https://httpbin.org/post" v-on:add="add" v-if="!file")
    croppie(ref="croppie" v-bind:file="file" type="circle" v-else)
  md-dialog-actions
    md-button.md-primary(@click.native="close") Отмена
    md-button.md-primary(@click.native="save") Сохранить


</template>

<script lang="coffee">

# import Croppie from './Croppie.vue'
# import Dropzone from './Dropzone.vue'

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
  methods:
    close: -> @$emit 'close'
    save: ->
      @$refs.croppie.get (file) =>
        file = new FS.File file
        file.user = @id
        @$call 'removeUserPhoto', @id, (err, res) =>
          unless err?
            Mongo.Avatars.insert file, (err, res) => do @close
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
  // text-align center
  padding 10px
img
  height 100%
  // display none
</style>
