<template lang="jade">
.v-select-panel.l-column(@click="click")
  .search.l-row.l-padding(v-if="searching")
    v-button.v-icon-button.v-mini(@click.native="deselect")
      v-icon clear_all
    input.l-flex(ref="search" placeholder="Поиск" v-model="search")
    v-button.v-icon-button.v-mini(@click.native="clear")
      v-icon close
  v-divider
  v-scroller.content.l-flex(ref="scroller")
    slot(name="visible")

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
    search: -> do @filter
  mounted: ->
    do @filter
    @$nextTick ->
      @options = @$refs.scroller.$children
  methods:
    click: -> @$nextTick ->
      @$refs.search.focus() if @$refs.search?
    focus: (index, scroll=no) ->
      return unless _.get @$slots, 'default.length'
      @focused = index
      key = @$slots.visible[index]?.key
      for option in @$refs.scroller.$children
        option.focus = option.$vnode.key is key
      if scroll
        @$refs.scroller.scrollKey key
    open: ->
      do @filter
      @$refs.search.focus() if @$refs.search?
      $(document).off 'keydown', @keydown
      $(document).on 'keydown', @keydown
    close: ->
      $(document).off 'keydown', @keydown
    keydown: (e) ->
      if e.key is 'ArrowDown'
        do @next; do e.preventDefault
      else if e.key is 'ArrowUp'
        do @prev; do e.preventDefault
      else if e.key is 'Escape'
        @$emit 'close'; do e.preventDefault
      else if e.key is 'Enter'
        do e.preventDefault
        if @focused?
          option = _.find @options, focus: yes
          do option.select if option?
    next: ->
      if @$slots.visible.length
        unless @focused?
          index = 0
        else if @focused is @$slots.visible.length
          index = null
        else
          index = @focused + 1
      else
        index = null
      @focus index, yes
    prev: ->
      if @$slots.visible.length
        unless @focused?
          index = @$slots.visible.length-1
        else if @focused is 0
          index = null
        else
          index = @focused - 1
      else index = null
      @focus index, yes
    filter: ->
      return unless _.get @$slots, 'default.length'
      if _.isEmpty @search
        @$slots.visible = _.clone @$slots.default
        do @$forceUpdate
        @$nextTick ->
          @$refs.scroller.onScroll yes
          setTimeout =>
            @focus 0

        return

      getText = (children) ->
        return null unless children?
        text = ''
        for child in children
          if child.children
            subtext = getText child.children
            text += subtext if subtext?
          text += child.text if child.text?
        return text

      slots = []
      find = @search.toLowerCase()
      for option in @$slots.default
        search = _.get option, 'componentOptions.propsData.search'
        unless search?
          search = getText _.get option, 'componentOptions.children'
        search = _.toLower _.toString search
        if search.indexOf(find)+1
          slots.push option

      @$slots.visible = slots
      do @$forceUpdate
      @$nextTick ->
        @$refs.scroller.onScroll yes
        setTimeout =>
          @focus 0
    select: (value) ->
      if @multiple
        if value in @val
          @val = _.without @val, value
        else
          @val.push value
      else
        @val = value
        @$emit 'close'
    clear: ->
      @search = ''
      @filter()
    deselect: ->
      if @multiple
        @val = []
        do @filter
      else
        @val = null
        @$emit 'close'

return component
</script>
