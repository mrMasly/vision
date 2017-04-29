<template lang="jade">
v-dialog.v-dialog-alert(ref='dialog', @close='fireCloseEvent()')
  v-dialog-title(v-if='mdTitle') {{ mdTitle }}
  v-dialog-content(v-if='mdContentHtml', v-html='mdContentHtml')
  v-dialog-content(v-else='') {{ mdContent }}
  v-dialog-actions
    v-button.v-primary(@click.native='close()') {{ mdOkText }}
</template>

<script lang="coffee">
component =
  name: 'vue-dialog-alert'
  props:
    mdTitle: String
    mdContent: String
    mdContentHtml: String
    mdOkText:
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
    if !@mdContent and !@mdContentHtml
      throw new Error('Missing v-content or v-content-html attributes')

return component
</script>
