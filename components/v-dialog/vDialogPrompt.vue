<template lang="jade">
v-dialog.v-dialog-prompt(ref='dialog', @close="fireCloseEvent('cancel')")
  v-dialog-title(v-if='title') {{ title }}
  v-dialog-content(v-if='contentHtml', v-html='contentHtml')
  v-dialog-content(v-if='content') {{ content }}
  v-dialog-content
    v-input-container
      v-input(ref='input', :id='inputId', :name='inputName', :maxlength='inputMaxlength', :placeholder='inputPlaceholder', :value='value', @keydown.enter.native='confirmValue')
  v-dialog-actions
    v-button.v-primary(@click.native="close('cancel')") {{ cancelText }}
    v-button.v-primary(@click.native='confirmValue') {{ okText }}

</template>

<script lang="coffee">
component =
  name: 'v-dialog-prompt'
  props:
    value:
      type: [String, Number]
      required: true
    title: String
    content: String
    contentHtml: String
    okText:
      type: String
      default: 'Ok'
    cancelText:
      type: String
      default: 'Cancel'
    inputId: String
    inputName: String
    inputMaxlength: [String, Number]
    inputPlaceholder: String
  data: ->
    debounce: false
  methods:
    fireCloseEvent: (type) ->
      if !@debounce
        @$emit 'close', type
    open: ->
      @$emit 'open'
      @debounce = false
      @$refs.dialog.open()
      window.setTimeout =>
        @$refs.input.$el.focus()
    close: (type) ->
      @fireCloseEvent type
      @debounce = true
      @$refs.dialog.close()
    confirmValue: ->
      @$emit 'input', @$refs.input.$el.value
      @close 'ok'


return component
</script>
