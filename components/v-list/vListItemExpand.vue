<template lang="jade">
li.v-list-item.v-list-item-expand(:class='classes')
  .v-list-item-container.v-button
    slot
    v-icon.v-list-expand-indicator keyboard_arrow_down
  v-button.v-button-ghost(type='button', @click.native='toggleExpandList', :disabled='disabled')
  .v-list-expand(ref='expand', :class='expandClasses', :style='expandStyles')
    slot(name='expand')
</template>

<script lang="coffee">
component =
  name: 'v-list-item'
  props:
    disabled: Boolean
    expandMultiple: Boolean
  data: ->
    parentList: false
    active: false
    height: 0
    contentObserver: null
    transitionOff: true
  computed:
    classes: ->
      'v-disabled': @disabled
      'v-active': @active
    expandClasses: ->
      'v-transition-off': @transitionOff
    expandStyles: ->
      'margin-bottom': @height
  methods:
    resetSiblings: ->
      _this = this
      @parentList.$children.forEach (child) ->
        if child.$el != _this.$el and child.$el.classList.contains('v-list-item-expand')
          child.active = false
    calculatePadding: ->

      window.requestAnimationFrame =>
        @height = -@$el.scrollHeight + 'px'
        setTimeout =>
          @transitionOff = false
    toggleExpandList: ->
      if !@expandMultiple
        @resetSiblings()
      @calculatePadding()
      @active = !@active
    recalculateAfterChange: ->
      @transitionOff = true
      @calculatePadding()
    observeChildChanges: ->
      @contentObserver = new MutationObserver(@recalculateAfterChange)
      @contentObserver.observe @$refs.expand,
        childList: true
        characterData: true
        subtree: true
  mounted: ->
    @$nextTick ->
      @parentList = getClosestVueParent(@$parent, 'v-list')
      @calculatePadding()
      @observeChildChanges()
      window.addEventListener 'resize', @recalculateAfterChange
  beforeDestroy: ->
    if @contentObserver
      @contentObserver.disconnect()
    window.removeEventListener 'resize', @recalculateAfterChange

return component
</script>
