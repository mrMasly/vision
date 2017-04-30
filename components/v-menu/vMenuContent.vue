<template lang="jade">
.v-menu-content(@keydown.esc.prevent='close', @keydown.tab.prevent='close', @keydown.up.prevent="highlightItem('up')", @keydown.down.prevent="highlightItem('down')", @keydown.enter.prevent='fireClick', @keydown.space.prevent='fireClick', tabindex='-1')
  v-list
    slot
</template>

<script lang="coffee">
component =
  name: 'v-menu-content'
  data: ->
    oldHighlight: false
    highlighted: false
    itemsAmount: 0
  methods:
    close: ->
      @highlighted = false
      @$parent.close()
    highlightItem: (direction) ->
      @oldHighlight = @highlighted
      if direction == 'up'
        if @highlighted == 1
          @highlighted = @itemsAmount
        else
          @highlighted--
      if direction == 'down'
        if @highlighted == @itemsAmount
          @highlighted = 1
        else
          @highlighted++
    fireClick: ->
      if @highlighted > 0
        @$children[0].$children[@highlighted - 1].$el.click()
  mounted: ->
    if !@$parent.$el.classList.contains('v-menu')
      @$destroy()
      throw new Error('You must wrap the v-menu-content in a v-menu')

return component
</script>
