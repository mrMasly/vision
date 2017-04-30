<template lang="jade">
v-dialog.v-dialog-confirm(ref='dialog', @close="fireCloseEvent('cancel')")
  v-dialog-title(v-if='title') {{ title }}
  v-dialog-content(v-if='contentHtml', v-html='contentHtml')
  v-dialog-content(v-else='') {{ content }}
  v-dialog-actions
    v-button.v-primary(@click.native="close('cancel')") {{ cancelText }}
    v-button.v-primary(@click.native="close('ok')") {{ okText }}

</template>

<script lang="coffee">
component =
  name: 'v-dialog-confirm'
  props:
    title: String
    content: String
    contentHtml: String
    okText:
      type: String
      default: 'Ok'
    cancelText:
      type: String
      default: 'Cancel'
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
    close: (type) ->
      @fireCloseEvent type
      @debounce = true
      @$refs.dialog.close()
  mounted: ->
    if !@content and !@contentHtml
      throw new Error('Missing v-content or v-content-html attributes')

return component
</script>
