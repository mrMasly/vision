<template>

  <form :action="url" class="vue-dropzone dropzone" ref="dropzone"></form>

</template>

<script lang="coffee">
component =
  module: module
  props:
    id: type: String
    url:
      type: String
      default: 'https://httpbin.org/post'
    clickable:
      type: Boolean
      default: true
    acceptedFileTypes: type: String
    thumbnailHeight:
      type: Number
      default: 200
    thumbnailWidth:
      type: Number
      default: 200
    showRemoveLink:
      type: Boolean
      default: true
    maxFileSizeInMB:
      type: Number
      default: 2
    maxNumberOfFiles:
      type: Number
      default: 5
    autoProcessQueue:
      type: Boolean
      default: false
    useFontAwesome:
      type: Boolean
      default: false
    headers: type: Object
    language:
      type: Object
      default: ->
        dictDefaultMessage: '<br>Нажмите, чтобы выбрать файл.<br>Или перетащите файл сюда.'
        dictCancelUpload: 'Отменить загрузку'
        dictCancelUploadConfirmation: 'Вы уверены, что хотите отменить загрузку?'
        dictFallbackMessage: 'Ваш браузер не поддерживает перетаскивание файлов для загрузки.'
        dictFallbackText: 'Please use the fallback form below to upload your files like in the olden days.'
        dictFileTooBig: 'Файл слишком большой ({{filesize}}MiB). Максимальный размер файла: {{maxFilesize}}MiB.'
        dictInvalidFileType: 'Вы не можете загружать файлы этого типа.'
        dictMaxFilesExceeded: 'Вы не можете загрузить больше файлов. (Максимум: {{maxFiles}})'
        dictRemoveFile: 'Удалить'
        dictRemoveFileConfirmation: null
        dictResponseError: 'Server responded with {{statusCode}} code.'

    useCustomDropzoneOptions:
      type: Boolean
      default: false
    dropzoneOptions: type: Object
  data: ->
    cloudIcon: '<i class="material-icons">cloud_upload</i>'
    doneIcon: ' <i class="material-icons">done</i>'
    errorIcon: ' <i class="material-icons">error</i>'
  methods:
    setOption: (option, value) ->
      @dropzone.options[option] = value
      return
    removeAllFiles: ->
      @dropzone.removeAllFiles true
      return
    processQueue: ->
      @dropzone.processQueue()
      return
    removeFile: (file) ->
      @dropzone.removeFile file
      return
  mounted: ->
    if @$isServer
      return
    Dropzone = require('dropzone/index.js')
    Dropzone.autoDiscover = false
    element = @$refs.dropzone
    if !@useCustomDropzoneOptions
      @dropzone = new Dropzone(element,
        clickable: @clickable
        thumbnailWidth: @thumbnailWidth
        thumbnailHeight: @thumbnailHeight
        maxFiles: @maxNumberOfFiles
        maxFilesize: @maxFileSizeInMB
        addRemoveLinks: @showRemoveLink
        acceptedFiles: @acceptedFileTypes
        autoProcessQueue: @autoProcessQueue
        headers: @headers
        previewTemplate: '<div class="dz-preview dz-file-preview">  <div class="dz-image" style="width:' + @thumbnailWidth + 'px;height:' + @thumbnailHeight + 'px"><img data-dz-thumbnail /></div>  <div class="dz-details">    <div class="dz-size"><span data-dz-size></span></div>    <div class="dz-filename"><span data-dz-name></span></div>  </div>  <div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></div>  <div class="dz-error-message"><span data-dz-errormessage></span></div>  <div class="dz-success-mark">' + @doneIcon + ' </div>  <div class="dz-error-mark">' + @errorIcon + '</div></div>'
        dictDefaultMessage: @cloudIcon + @language.dictDefaultMessage
        dictCancelUpload: @language.dictCancelUpload
        dictCancelUploadConfirmation: @language.dictCancelUploadConfirmation
        dictFallbackMessage: @language.dictFallbackMessage
        dictFallbackText: @language.dictFallbackText
        dictFileTooBig: @language.dictFileTooBig
        dictInvalidFileType: @language.dictInvalidFileType
        dictMaxFilesExceeded: @language.dictMaxFilesExceeded
        dictRemoveFile: @language.dictRemoveFile
        dictRemoveFileConfirmation: @language.dictRemoveFileConfirmation
        dictResponseError: @language.dictResponseError)
    else
      @dropzone = new Dropzone(element, @dropzoneOptions)
    # Handle the dropzone events
    vm = this
    @dropzone.on 'thumbnail', (file) =>
      @$emit 'vdropzone-thumbnail', file
    @dropzone.on 'addedfile', (file) =>
      @$emit 'add', file
    @dropzone.on 'removedfile', (file) =>
      @$emit 'vdropzone-removed-file', file
    @dropzone.on 'success', (file, response) =>
      @$emit 'vdropzone-success', file, response
    @dropzone.on 'successmultiple', (file, response) =>
      @$emit 'vdropzone-success-multiple', file, response
    @dropzone.on 'error', (file, error, xhr) =>
      @$emit 'vdropzone-error', file, error, xhr
    @dropzone.on 'sending', (file, xhr, formData) =>
      @$emit 'vdropzone-sending', file, xhr, formData
    @dropzone.on 'sendingmultiple', (file, xhr, formData) =>
      @$emit 'vdropzone-sending-multiple', file, xhr, formData
    @dropzone.on 'queuecomplete', (file, xhr, formData) =>
      @$emit 'vdropzone-queue-complete', file, xhr, formData
  beforeDestroy: ->
    @dropzone.destroy()


return component
</script>

<style lang="stylus">

.vue-dropzone
  height 100%
  border 2px solid #E5E5E5;
  font-family 'Arial', sans-serif
  letter-spacing 0.2px
  color #777
  transition background-color .2s linear
  .dz-message
    text-align center
  &:hover
    background-color #F6F6F6
  i
    color #CCC
  .dz-preview
    .dz-image
      border-radius 0px
      &:hover
        img
          transform none
          -webkit-filter none
    .dz-details
      bottom 0px
      top 0px
      color white
      background-color rgba(33, 150, 243, 0.8)
      transition opacity .2s linear
      text-align left
      .dz-filename span, .dz-size span
        background-color transparent
      .dz-filenamenot(:hover) span
        border none
      .dz-filename:hover span
        background-color transparent
        border none
    .dz-progress .dz-upload
      background #cccccc
    .dz-remove
      position absolute
      z-index 30
      color white
      margin-left 15px
      padding 10px
      top inherit
      bottom 15px
      border 2px white solid
      text-decoration none
      text-transform uppercase
      font-size 0.8rem
      font-weight 800
      letter-spacing 1.1px
      opacity 0
    &:hover
      .dz-remove
        opacity 1
    .dz-success-mark, .dz-error-mark
      margin-left auto !important
      margin-top auto !important
      width 100% !important
      top 35% !important
      left 0
      i
        color white !important
        font-size 5rem !important
</style>
