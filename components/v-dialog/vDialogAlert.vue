<template lang="jade">
md-dialog.md-dialog-alert(ref='dialog', @close='fireCloseEvent()')
  md-dialog-title(v-if='mdTitle') {{ mdTitle }}
  md-dialog-content(v-if='mdContentHtml', v-html='mdContentHtml')
  md-dialog-content(v-else='') {{ mdContent }}
  md-dialog-actions
    md-button.md-primary(@click.native='close()') {{ mdOkText }}
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
      throw new Error('Missing md-content or md-content-html attributes')

return component
</script>
