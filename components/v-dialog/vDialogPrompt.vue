<template lang="jade">
v-dialog.v-dialog-prompt(ref='dialog', @close="fireCloseEvent('cancel')")
  v-dialog-title(v-if='vTitle') {{ vTitle }}
  v-dialog-content(v-if='vContentHtml', v-html='vContentHtml')
  v-dialog-content(v-if='vContent') {{ vContent }}
  v-dialog-content
    v-input-container
      v-input(ref='input', :id='vInputId', :name='vInputName', :maxlength='vInputMaxlength', :placeholder='vInputPlaceholder', :value='value', @keydown.enter.native='confirmValue')
  v-dialog-actions
    v-button.v-primary(@click.native="close('cancel')") {{ vCancelText }}
    v-button.v-primary(@click.native='confirmValue') {{ vOkText }}

</template>

<script lang="coffee">
component =
  name: 'v-dialog-prompt'
  props:
    value:
      type: [String, Number]
      required: true
    vTitle: String
    vContent: String
    vContentHtml: String
    vOkText:
      type: String
      default: 'Ok'
    vCancelText:
      type: String
      default: 'Cancel'
    vInputId: String
    vInputName: String
    vInputMaxlength: [String, Number]
    vInputPlaceholder: String
  data: ->
    debounce: false
  methods:
    fireCloseEvent: (type) ->
      if !@debounce
        @$emit 'close', type
    open: ->
      _this = this
      @$emit 'open'
      @debounce = false
      @$refs.dialog.open()
      window.setTimeout ->
        _this.$refs.input.$el.focus()
    close: (type) ->
      @fireCloseEvent type
      @debounce = true
      @$refs.dialog.close()
    confirmValue: ->
      @$emit 'input', @$refs.input.$el.value
      @close 'ok'


return component
</script>
