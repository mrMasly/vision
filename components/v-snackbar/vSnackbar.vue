<template lang="jade">
.v-snackbar(:class='[themeClass, classes]', :id='snackbarId', @mouseenter='pauseTimeout', @mouseleave='resumeTimeout')
  .v-snackbar-container(ref='container')
    .v-snackbar-content
      slot
</template>

<script lang="coffee">

import transitionEndEventName from '../../utils/transitionEndEventName.js'
import theme from '../../theme/mixin.js'
import manager from './manager'

component =
  name: 'v-snackbar'
  props:
    id: [String, Number]
    vPosition:
      type: String
      default: 'bottom center'
    vDuration:
      type: [String, Number]
      default: 4000
  mixins: [ theme ]
  data: ->
    snackbarId: @id or 'snackbar-' + Random.id()
    active: false
    rootElement: {}
    snackbarElement: {}
    directionClass: null
    closeTimeout: null
  computed: classes: ->
    cssClasses = 'v-active': @active
    @directionClass = @vPosition.replace(RegExp(' ', 'g'), '-')
    cssClasses['v-position-' + @directionClass] = true
    cssClasses
  watch: active: (_active) ->
    directionClass = 'v-has-toast-' + @directionClass
    toastClass = 'v-has-toast'
    if _active
      document.body.classList.add directionClass
      document.body.classList.add toastClass
    else
      document.body.classList.remove directionClass
      document.body.classList.remove toastClass
  methods:
    removeElement: ->
      if document.body.contains(@snackbarElement)
        activeRipple = @snackbarElement.querySelector('.v-ripple.v-active')
        if activeRipple
          activeRipple.classList.remove 'v-active'
        document.body.removeChild @snackbarElement
    open: ->
      if manager.current
        manager.current.close()
      manager.current = this
      document.body.appendChild @snackbarElement
      window.getComputedStyle(@$refs.container).backgroundColor
      @active = true
      @$emit 'open'
      @closeTimeout = window.setTimeout(@close, @vDuration)
      @timeoutStartedAt = Date.now()
    close: ->
      _this = this
      if @$refs.container

        removeElement = ->
          _this.$refs.container.removeEventListener transitionEndEventName, removeElement
          _this.removeElement()

        manager.current = null
        @active = false
        @$emit 'close'
        @$refs.container.removeEventListener transitionEndEventName, removeElement
        @$refs.container.addEventListener transitionEndEventName, removeElement
        window.clearTimeout @closeTimeout
        @pendingDuration = @vDuration
    pauseTimeout: ->
      @pendingDuration = @pendingDuration - (Date.now() - (@timeoutStartedAt))
      @timeoutStartedAt = 0
      window.clearTimeout @closeTimeout
    resumeTimeout: ->
      @timeoutStartedAt = Date.now()
      @closeTimeout = window.setTimeout(@close, @pendingDuration)
  mounted: ->
    _this2 = this
    @$nextTick ->
      _this2.snackbarElement = _this2.$el
      _this2.snackbarElement.parentNode.removeChild _this2.snackbarElement
      _this2.timeoutStartedAt = 0
      _this2.pendingDuration = _this2.vDuration
  beforeDestroy: ->
    window.clearTimeout @closeTimeout
    @removeElement()



return component
</script>
