<template lang="jade">
v-dialog.v-dialog-confirm(ref='dialog', @close="fireCloseEvent('cancel')")
  v-dialog-title(v-if='vTitle') {{ vTitle }}
  v-dialog-content(v-if='vContentHtml', v-html='vContentHtml')
  v-dialog-content(v-else='') {{ vContent }}
  v-dialog-actions
    v-button.v-primary(@click.native="close('cancel')") {{ vCancelText }}
    v-button.v-primary(@click.native="close('ok')") {{ vOkText }}

</template>

<script lang="coffee">
component =
  name: 'v-dialog-confirm'
  props:
    vTitle: String
    vContent: String
    vContentHtml: String
    vOkText:
      type: String
      default: 'Ok'
    vCancelText:
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
    if !@vContent and !@vContentHtml
      throw new Error('Missing v-content or v-content-html attributes')

return component
</script>
