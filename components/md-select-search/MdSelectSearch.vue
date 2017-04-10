<template lang="jade">
main.l-row.l-padding
  input.l-flex(placeholder="Поиск" v-model="val" @keyup="change" autofocus
  @keydown.down="next")
  md-button.md-icon-button.md-dense(@click.native="val=''; change()")
    md-icon close
</template>

<script lang="coffee">
component =
  name: 'md-select-search'
  data: ->
    val: @value
    list: null
  props:
    value:
      type: String
      required: yes
  methods:
    change: ->
      @$emit 'input', @val
      @$emit 'change', @val
      # setTimeout =>
      #
      # , 100
    next: ->
      console.log 'next'
  mounted: ->
    @list = $(@$parent.$el)
    content = @list.parent()
    content.css
      overflow: 'hidden'
      display: 'flex'
      flexDirection: 'column'
      minHeight: 300
    @list.css
      overflow: 'auto'
      flex: 1
    content.prepend(@$el)
return component
</script>

<style lang="stylus" scoped>
main
  height 50px
  margin 0
  border-bottom solid 1px rgba(0,0,0,.12)
input
  margin-left 7px
  border none
  outline none
  box-shadow none
  font-size 16px
.md-button
  position relative
</style>
