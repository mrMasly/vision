<template lang="jade">
.v-dialog-container(:class='[themeClass, classes]', @keyup.esc.stop='closeOnEsc', tabindex='0')
  .v-dialog(ref='dialog', :style='styles', :class='dialogClasses')
    slot
  v-backdrop.v-dialog-backdrop(:class='classes', v-if='backdrop', ref='backdrop', @close='clickOutsideToClose && close()')
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js';
component =
  name: 'v-dialog'
  props:
    clickOutsideToClose:
      type: Boolean
      default: true
    escToClose:
      type: Boolean
      default: true
    backdrop:
      type: Boolean
      default: true
    openFrom: String
    closeTo: String
    fullscreen:
      type: Boolean
      default: false
  mixins: [ theme ]
  data: ->
    active: false
    transitionOff: false
    dialogTransform: ''
  computed:
    classes: ->
      'v-active': @active
    dialogClasses: ->
      'v-fullscreen': @fullscreen
      'v-transition-off': @transitionOff
      'v-reference': @openFrom or @closeTo
    styles: ->
      transform: @dialogTransform
  methods:
    removeDialog: ->
      if document.body.contains(@dialogElement)
        @$el.parentNode.removeChild @$el
    calculateDialogPos: (ref) ->
      reference = document.querySelector(ref)
      if reference
        openFromRect = reference.getBoundingClientRect()
        dialogRect = @dialogInnerElement.getBoundingClientRect()
        widthInScale = openFromRect.width / dialogRect.width
        heightInScale = openFromRect.height / dialogRect.height
        distance =
          top: -(dialogRect.top - (openFromRect.top))
          left: -(dialogRect.left - (openFromRect.left) + openFromRect.width)
        if openFromRect.top > dialogRect.top + dialogRect.height
          distance.top = openFromRect.top - (dialogRect.top)
        if openFromRect.left > dialogRect.left + dialogRect.width
          distance.left = openFromRect.left - (dialogRect.left) - (openFromRect.width)
        @dialogTransform = 'translate3D(' + distance.left + 'px, ' + distance.top + 'px, 0) scale(' + widthInScale + ', ' + heightInScale + ')'
      return
    open: ->
      document.body.appendChild @dialogElement
      @transitionOff = true
      @calculateDialogPos @openFrom
      window.setTimeout =>
        @dialogElement.focus()
        @transitionOff = false
        @active = true
      @$emit 'open'
    closeOnEsc: ->
      if @vEscToClose
        @close()
    close: ->
      if document.body.contains(@dialogElement)
        @$nextTick ->

          cleanElement = =>
            activeRipple = @dialogElement.querySelector('.v-ripple.v-active')
            if activeRipple
              activeRipple.classList.remove 'v-active'
            @dialogInnerElement.removeEventListener transitionEndEventName, cleanElement
            document.body.removeChild @dialogElement
            @dialogTransform = ''

          @transitionOff = true
          @dialogTransform = ''
          @calculateDialogPos @closeTo
          setTimeout =>
            @transitionOff = false
            @active = false
            @dialogInnerElement.addEventListener transitionEndEventName, cleanElement
          @$emit 'close'

  mounted: ->
    @$nextTick ->
      @dialogElement = @$el
      @dialogInnerElement = @$refs.dialog
      @removeDialog()
  beforeDestroy: ->
    @removeDialog()

return component
</script>
