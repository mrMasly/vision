<template lang="jade">
v-dialog.v-dialog-alert(ref='dialog', @close='fireCloseEvent()')
  v-dialog-title(v-if='title') {{ title }}
  v-dialog-content(v-if='contentHtml', v-html='contentHtml')
  v-dialog-content(v-else='') {{ content }}
  v-dialog-actions
    v-button.v-primary(@click.native='close()') {{ okText }}
</template>

<script lang="coffee">
component =
  name: 'vue-dialog-alert'
  props:
    title: String
    content: String
    contentHtml: String
    okText:
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
    if !@content and !@contentHtml
      throw new Error('Missing v-content or v-content-html attributes')

return component
</script>
