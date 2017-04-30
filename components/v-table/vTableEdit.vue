<template lang="jade">
.v-table-edit(@keydown.esc='closeDialog')
  .v-table-edit-trigger(:class='triggerClasses', @click.stop='openDialog')
    | {{ value || placeholder }}
  .v-table-dialog(:class='dialogClasses', ref='dialog')
    v-input-container
      v-input(ref='input', :id='id', :name='name', :maxlength='maxlength', :value='value', :placeholder='placeholder', @keydown.enter.native='confirmDialog')
</template>

<script lang="coffee">
component =
  name: 'v-table-edit'
  props:
    value: [String, Number]
    large: Boolean
    id: String
    name: String
    placeholder: String
    maxlength: [Number, String]
  data: ->
    active: false
  computed:
    triggerClasses: ->
      'v-edited': @value
    dialogClasses: ->
      'v-active': @active
      'v-large': @large
    realValue: ->
      console.log @value
  methods:
    openDialog: ->
      @active = true
      @$refs.input.$el.focus()
      document.addEventListener 'click', @closeDialogOnOffClick
    closeDialog: ->
      if @active
        @active = false
        @$refs.input.$el.blur()
        document.removeEventListener 'click', @closeDialogOnOffClick
    closeDialogOnOffClick: (event) ->
      if !@$refs.dialog.contains(event.target)
        @closeDialog()
    confirmDialog: ->
      value = @$refs.input.$el.value
      @closeDialog()
      @$emit 'input', value
      @$emit 'edited', value

return component
</script>
