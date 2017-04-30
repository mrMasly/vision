<template lang="jade">
v-dialog.v-dialog-alert(ref='dialog', @close='fireCloseEvent()')
  v-dialog-title(v-if='vTitle') {{ vTitle }}
  v-dialog-content(v-if='vContentHtml', v-html='vContentHtml')
  v-dialog-content(v-else='') {{ vContent }}
  v-dialog-actions
    v-button.v-primary(@click.native='close()') {{ vOkText }}
</template>

<script lang="coffee">
component =
  name: 'vue-dialog-alert'
  props:
    vTitle: String
    vContent: String
    vContentHtml: String
    vOkText:
      type: String
      default: 'Ok'
  data: ->
    debounce: false
  methods:
    fireCloseEvent: ->
      if !@debounce
        @$emit 'close'
    open: ->
      @$emit 'open'
      @debounce = false
      @$refs.dialog.open()
    close: ->
      @fireCloseEvent()
      @debounce = true
      @$refs.dialog.close()
  mounted: ->
    if !@vContent and !@vContentHtml
      throw new Error('Missing v-content or v-content-html attributes')

return component
</script>
