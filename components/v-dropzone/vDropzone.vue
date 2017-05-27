<template>

  <form :action="url" class="v-dropzone dropzone" ref="dropzone"></form>

</template>

<script lang="coffee">
component =
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
    Dropzone = require('dropzone/dist/dropzone.js')
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
