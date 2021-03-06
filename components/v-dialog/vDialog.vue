<template lang="jade">
.v-dialog-container.no-print(:class='[themeClass, classes]', @keyup.esc.stop='closeOnEsc', tabindex='0')
  .v-dialog(ref='dialog', :style='styles', :class='dialogClasses')
    slot(v-if="mounted")
  v-backdrop.v-dialog-backdrop(:class='classes', v-if='backdrop', ref='backdrop', @close='clickOutsideToClose && close()')
</template>

<script lang="coffee">
import _ from 'lodash'
import theme from '../../theme/mixin.js';
import transitionEndEventName from '../../utils/transitionEndEventName.js'
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
    routeParam:
      type: [String, Boolean]
      default: no
    queryParam:
      type: [String, Boolean]
      default: no
  mixins: [ theme ]
  data: ->
    active: false
    transitionOff: false
    dialogTransform: ''
    mounted: no
    activeElement: null
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
      @mounted = yes
      @activeElement = document.activeElement
      document.body.appendChild @dialogElement
      @transitionOff = true
      @calculateDialogPos @openFrom
      window.setTimeout =>
        @dialogElement.focus()
        @transitionOff = false
        @active = true
      @$emit 'open'
    closeOnEsc: ->
      if @escToClose
        @close()
    close: ->
      if document.body.contains(@dialogElement)
        @$nextTick ->

          if @activeElement?
            @activeElement.focus()
            @activeElement = ''

          cleanElement = =>
            activeRipple = @dialogElement.querySelector('.v-ripple.v-active')
            if activeRipple
              activeRipple.classList.remove 'v-active'
            @dialogInnerElement.removeEventListener transitionEndEventName, cleanElement
            document.body.removeChild @dialogElement
            @dialogTransform = ''
            @mounted = no

          @transitionOff = true
          @dialogTransform = ''
          @calculateDialogPos @closeTo
          setTimeout =>
            @transitionOff = false
            @active = false
            @dialogInnerElement.addEventListener transitionEndEventName, cleanElement
          @$emit 'close'
      # после закрытие изменяем параметр роутера если он указан в props
      setTimeout =>
        if @routeParam and @$route.params[@routeParam]?
          route =
            name: @$route.name
            params: _.omit @$route.params, @routeParam
          @$router.push route
        else if @queryParam and @$route.query[@queryParam]?
          route = {}
          route.name = @$route.name unless _.isEmpty @$route.name
          route.params = @$route.params unless _.isEmpty @$route.params
          route.query = _.omit @$route.query, @queryParam
          @$router.push route

      , 300
    triggerRouteParam: ->
      return unless @routeParam
      param = @$route.params[@routeParam]
      if param and not @active
        do @open
      else if not param and @active
        do @close
    triggerQueryParam: ->
      return unless @queryParam
      param = @$route.query[@queryParam]
      if param and not @active
        do @open
      else if not param and @active
        do @close
  mounted: ->
    # @mounted = yes
    @$nextTick ->
      @dialogElement = @$el
      @dialogInnerElement = @$refs.dialog
      @removeDialog()
      do @triggerRouteParam
      do @triggerQueryParam
  beforeDestroy: ->
    @removeDialog()
  created: ->
    if @routeParam
      @$watch "$route.params.#{@routeParam}", @triggerRouteParam
    else if @queryParam
      @$watch "$route.query.#{@queryParam}", @triggerQueryParam



return component
</script>
