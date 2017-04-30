<template lang="jade">
v-list-item.v-menu-item(@click.native='close', :class='classes', :href='href', :target='target', :disabled='disabled')
  slot
</template>

<script lang="coffee">
import getClosestVueParent from '../../utils/getClosestVueParent.js'
if  Meteor.isClient
  require 'element.scrollintoviewifneeded-polyfill'
component =
  name: 'v-menu-item'
  props:
    href: String
    target: String
    disabled: Boolean
  data: ->
    parentContent: {}
    index: 0
  computed:
    classes: ->
      'v-highlighted': @highlighted
    highlighted: ->
      if @index == @parentContent.highlighted
        if @disabled
          if @parentContent.oldHighlight > @parentContent.highlighted
            @parentContent.highlighted--
          else
            @parentContent.highlighted++
        if @index == 1
          @parentContent.$el.scrollTop = 0
        else if @index == @parentContent.itemsAmount
          @parentContent.$el.scrollTop = @parentContent.$el.scrollHeight
        else
          @$el.scrollIntoViewIfNeeded false
        return true
      return false
  methods:
    close: ($event) ->
      if !@disabled
        if @parentMenu.vCloseOnSelect
          @parentContent.close()
        @$emit 'selected', $event
  mounted: ->
    @parentContent = getClosestVueParent(@$parent, 'v-menu-content')
    @parentMenu = getClosestVueParent(@$parent, 'v-menu')
    if !@parentContent
      @$destroy()
      throw new Error('You must wrap the v-menu-item in a v-menu-content')
    @parentContent.itemsAmount++
    @index = @parentContent.itemsAmount

return component
</script>
