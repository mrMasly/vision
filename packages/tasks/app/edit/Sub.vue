<template lang="jade">
.sub.l-row.l-start-start
  v-checkbox(v-model="sub.done" @change="save", :disabled="disabledCheckbox")
  .title.l-flex(v-if="task.disables.subs") {{sub.title}}
  textarea.l-flex(v-model="sub.title" v-else
  @keydown="$emit('keydown', index, $event)"
  rows="1" ref="text" @input="save" @change="save")
  //- v-button.v-icon-button.v-mini

  .remove.has-ripple.l-relative(@click="remove")
    v-ripple
    v-icon close
</template>

<script lang="coffee">
import autosize from 'autosize'
component =
  name: 'subb'
  props:
    task: Object
    sub: Object
    index: Number
  mounted: -> @$nextTick ->
    autosize @$refs.text
  beforeDestroy: ->
    autosize.destroy @$refs.text
  methods:
    save: -> @$emit 'save'
    remove: -> @$emit 'remove', @index
  computed:
    disabledCheckbox: ->
      return yes if @task.users.length
      return no
return component
</script>

<style lang="stylus" scoped>
.v-checkbox
  margin 2px
  overflow hidden
.title
  margin-left 4px
.v-input-container
  min-height 30px !important
  margin 0
  padding-top 0
  margin-top -1px
  margin-bottom -5px
  margin-left 4px
  &:after
    display none
textarea
  margin-top 1px
  border none
  outline none
  box-shadow none
  font-size 1em
  resize none
.remove
  opacity .3
  cursor pointer
  border-radius 50% !important
  overflow hidden
  user-select none
  transition opacity .1s
  &:hover
    opacity .8
</style>
