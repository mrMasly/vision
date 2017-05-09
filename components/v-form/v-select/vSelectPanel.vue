<template lang="jade">
.v-select-panel.l-column(@click="click")
  .search.l-row.l-padding(v-if="search")
    v-button.v-icon-button.v-mini(@click.native="deselect")
      v-icon clear_all
    input.l-flex(ref="search" placeholder="Поиск" v-model="text")
    v-button.v-icon-button.v-mini(@click.native="clear")
      v-icon close
  v-divider

  .l-row.l-center-center(v-if="searching", :style="{height:searchingHeight+'px'}")
    v-spinner(indeterminate)

  v-scroller.content.l-flex(ref="scroller" v-else)
    slot(name="visible")

  template(v-if="add && text")
    v-option.l-row(value="__add__" key="__add__")
      span.l-flex Создать "{{text}}"
      span(style="float:right;color:rgba(0,0,0,.54);font-size:.8em") shift + enter

</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'v-select-panel'
  data: ->
    text: ''
    options: []
    focused: null
    val: null
    searching: no
    searchingHeight: 100
  created: ->
    if @multiple
      if _.isArray @value
        @val = _.clone @value
      else
        @val = []
    else
      @val = _.clone @value
  props: [ 'multiple', 'value', 'search', 'add' ]
  watch:
    text: ->
      if _.isFunction @search
        scroller = @$refs.scroller?.$el
        if scroller
          @searchingHeight = $(@$refs.scroller.$el).height()
        else
          @searchingHeight = 100
        @searchingHeight = 100 if @searchingHeight < 100
        @searching = yes
        @search @text, =>
          @searching = no
          @$nextTick => do @filter
      else do @filter
  mounted: ->
    do @filter
    @$nextTick ->
      @options = @$refs.scroller.$children
  methods:
    onAdd: ->
      return unless @add
      if _.isFunction @add
        @add @text, (value) =>
          @text = ''
          @select(value) if value
    click: -> @$nextTick ->
      @$refs.search.focus() if @$refs.search?
    focus: (index, scroll=no) ->
      return unless _.get @$slots, 'default.length'
      return if _.isEmpty @$slots.visible
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
        if e.shiftKey
          do @onAdd
        else if @focused?
          option = _.find @options, focus: yes
          do option.select if option?
    next: ->
      if @$slots.visible? && @$slots.visible.length
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
      if @$slots.visible? && @$slots.visible.length
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
      if _.isFunction(@search) or _.isEmpty @text
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
      find = @text.toLowerCase()
      for option in @$slots.default
        text = _.get option, 'componentOptions.propsData.search'
        unless text?
          text = getText _.get option, 'componentOptions.children'
        text = _.toLower _.toString text
        if text.indexOf(find)+1
          slots.push option

      @$slots.visible = slots
      do @$forceUpdate
      @$nextTick ->
        @$refs.scroller.onScroll yes
        setTimeout =>
          @focus 0
    select: (value) ->
      return do @onAdd if value is '__add__'
      if @multiple
        if value in @val
          @val = _.without @val, value
        else
          @val.push value
      else
        @val = value
        @$emit 'close'
    clear: ->
      @text = ''
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
