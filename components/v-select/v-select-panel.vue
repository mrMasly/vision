<template lang="jade">
.v-select-panel.l-column(@keydown="keydown" @click="click")
  .search.l-row.l-padding(v-if="searching")
    md-button.md-icon-button.md-mini(@click.native="deselect")
      md-icon clear_all
    input.l-flex(ref="search" placeholder="Поиск" @keyup="filter" v-model="search")
    md-button.md-icon-button.md-mini(@click.native="clear")
      md-icon close
  md-divider
  .content.l-flex.l-scroll
    slot(@select="select", :multiple="multiple")
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'v-select-panel'
  data: ->
    search: ''
    options: []
    focused: null
    val: null
  created: ->
    if @multiple
      if _.isArray @value
        @val = _.clone @value
      else
        @val = []
    else
      @val = _.clone @value
  props: [ 'multiple', 'value', 'searching' ]
  watch:
    val: ->
      for child in @$children
        do child.update if child.update?
  methods:
    click: -> @$nextTick ->
      @$refs.search.focus() if @$refs.search?
    focus: (focused) ->
      @focused = focused if focused?
      i = @focused
      option.focus = no for option in @options
      @options[i].focus = yes if @options[i]?
    open: ->
      do @filter
      @$refs.search.focus() if @$refs.search?
    keydown: (e) ->
      if e.code is 'ArrowDown'
        do @next; do e.preventDefault
      else if e.code is 'ArrowUp'
        do @prev; do e.preventDefault
      else if e.code is 'Escape'
        @$emit 'close'; do e.preventDefault
      else if e.code is 'Enter'
        do e.preventDefault
        if @focused?
          option = _.find @options, focus: yes
          do option.select if option?
    next: ->
      if @options.length
        unless @focused?
          @focused = 0
        else if @focused is @options.length-1
          @focused = null
        else
          @focused += 1
      else
        @focused = null
      do @focus
    prev: ->
      if @options.length
        unless @focused?
          @focused = @options.length-1
        else if @focused is 0
          @focused = null
        else
          @focused -= 1
      else @focused = null
      do @focus
    filter: ->
      @options = []
      options = _.filter @$children, (child) -> $(child.$el).is('.v-option')
      options = _.map options, (option) -> option
      for option in options
        if @search.length is ''
          option.show = yes
          @options.push option
        else if $(option.$el).text().toLowerCase().indexOf(@search.toLowerCase())+1
          option.show = yes
          @options.push option
        else
          option.show = no
          option.focus = no

      if @search isnt @_search
        @_search = @search
        @focused = 0
        do @focus
    select: (value) ->
      if @multiple
        if value in @val
          @val = _.without @val, value
        else
          @val.push value
        @$emit 'change', @val
      else
        @val = value
        @$emit 'change', @val
        @$emit 'close'
    clear: ->
      @search = ''
      @filter()
    deselect: ->
      if @multiple
        @val = []
        @$emit 'change', @val
      else
        @val = null
        @$emit 'change', @val
        @$emit 'close'

return component
</script>

<style lang="stylus" scoped>
.search
  height 56px !important
  min-height 56px !important
.v-select-panel
  z-index 999
  background-color #fff
input
  outline none
  box-shadow none
  border none
  font-size 1em
  margin-left 3px
.content > *:first-child
  margin-top 8px
.content > *:last-child
  margin-bottom 8px

.md-button
  margin 0 !important
</style>
