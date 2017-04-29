<template lang="jade">
.v-dialog-container(:class='[themeClass, classes]', @keyup.esc.stop='closeOnEsc', tabindex='0')
  .v-dialog(ref='dialog', :style='styles', :class='dialogClasses')
    slot
  v-backdrop.v-dialog-backdrop(:class='classes', v-if='vBackdrop', ref='backdrop', @close='vClickOutsideToClose && close()')
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js';
component =
  name: 'v-dialog'
  props:
    vClickOutsideToClose:
      type: Boolean
      default: true
    vEscToClose:
      type: Boolean
      default: true
    vBackdrop:
      type: Boolean
      default: true
    vOpenFrom: String
    vCloseTo: String
    vFullscreen:
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
      'v-fullscreen': @vFullscreen
      'v-transition-off': @transitionOff
      'v-reference': @vOpenFrom or @vCloseTo
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
      _this = this
      document.body.appendChild @dialogElement
      @transitionOff = true
      @calculateDialogPos @vOpenFrom
      window.setTimeout ->
        _this.dialogElement.focus()
        _this.transitionOff = false
        _this.active = true
        return
      @$emit 'open'
      return
    closeOnEsc: ->
      if @vEscToClose
        @close()
      return
    close: ->
      _this2 = this
      if document.body.contains(@dialogElement)
        @$nextTick ->

          cleanElement = ->
            activeRipple = _this2.dialogElement.querySelector('.v-ripple.v-active')
            if activeRipple
              activeRipple.classList.remove 'v-active'
            _this2.dialogInnerElement.removeEventListener transitionEndEventName, cleanElement
            document.body.removeChild _this2.dialogElement
            _this2.dialogTransform = ''
            return

          _this2.transitionOff = true
          _this2.dialogTransform = ''
          _this2.calculateDialogPos _this2.vCloseTo
          setTimeout ->
            _this2.transitionOff = false
            _this2.active = false
            _this2.dialogInnerElement.addEventListener transitionEndEventName, cleanElement
            return
          _this2.$emit 'close'
          return
      return
  mounted: ->
    _this3 = this
    @$nextTick ->
      _this3.dialogElement = _this3.$el
      _this3.dialogInnerElement = _this3.$refs.dialog
      _this3.removeDialog()
  beforeDestroy: ->
    @removeDialog()

return component
</script>
