<template lang="jade">
.v-tabs(:class='[themeClass, tabClasses]')
  v-whiteframe.v-tabs-navigation(v-tag='nav', :v-elevation='vElevation', :class='navigationClasses', ref='tabNavigation')
    button.v-tab-header(v-for='header in tabList', :key='header.id', type='button', :class='getHeaderClass(header)', :disabled='header.disabled', @click='setActiveTab(header)', ref='tabHeader')
      v-ink-ripple(:v-disabled='header.disabled')
      .v-tab-header-container
        v-icon(v-if='header.icon') {{ header.icon }}
        span(v-if='header.label') {{ header.label }}
        v-tooltip(v-if='header.tooltip', :direction='header.tooltipDirection', :v-delay='header.tooltipDelay') {{ header.tooltip }}
    span.v-tab-indicator(:class='indicatorClasses', ref='indicator')
  .v-tabs-content(ref='tabContent', :style='{ height: contentHeight }')
    .v-tabs-wrapper(:style='{ transform: `translate3D(-${contentWidth}, 0, 0)` }')
      slot
</template>

<script lang="coffee">

import { throttle } from 'lodash'
import theme from '../../theme/mixin.js'

component =
  name: 'v-tabs'
  props:
    vFixed: Boolean
    vCentered: Boolean
    vRight: Boolean
    vDynamicHeight:
      type: Boolean
      default: true
    vElevation:
      type: [String, Number]
      default: 0
  mixins: [ theme ]
  data: ->
    tabList: {}
    activeTab: null
    activeTabNumber: 0
    hasIcons: false
    hasLabel: false
    transitionControl: null
    transitionOff: false
    contentHeight: '0px'
    contentWidth: '0px'
  computed:
    tabClasses: ->
      'v-dynamic-height': @vDynamicHeight
      'v-transition-off': @transitionOff
    navigationClasses: ->
      'v-has-icon': @hasIcons
      'v-has-label': @hasLabel
      'v-fixed': @vFixed
      'v-right': !@vCentered and @vRight
      'v-centered': @vCentered or @vFixed
    indicatorClasses: ->
      toLeft = @lastIndicatorNumber > @activeTabNumber
      @lastIndicatorNumber = @activeTabNumber
        'v-transition-off': @transitionOff
        'v-to-right': !toLeft
        'v-to-left': toLeft
  methods:
    getHeaderClass: (header) ->
      'v-active': @activeTab == header.id
      'v-disabled': header.disabled
    registerTab: (tabData) ->
      @tabList[tabData.id] = tabData
    unregisterTab: (tabData) ->
      delete @tabList[tabData.id]
    updateTab: (tabData) ->
      @registerTab tabData
      if tabData.active
        if !tabData.disabled
          @setActiveTab tabData
        else if Object.keys(@tabList).length
          tabsIds = Object.keys(@tabList)
          targetIndex = tabsIds.indexOf(tabData.id) + 1
          target = tabsIds[targetIndex]
          if target
            @setActiveTab @tabList[target]
          else
            @setActiveTab @tabList[0]
    observeElementChanges: ->
      @parentObserver = new MutationObserver(throttle(@calculateOnWatch, 50))
      @parentObserver.observe @$refs.tabContent,
        childList: true
        attributes: true
        subtree: true
    getTabIndex: (id) ->
      idList = Object.keys(@tabList)
      idList.indexOf id
    calculateIndicatorPos: ->
      if @$refs.tabHeader and @$refs.tabHeader[@activeTabNumber]
        tabsWidth = @$el.offsetWidth
        activeTab = @$refs.tabHeader[@activeTabNumber]
        left = activeTab.offsetLeft
        right = tabsWidth - left - (activeTab.offsetWidth)
        @$refs.indicator.style.left = left + 'px'
        @$refs.indicator.style.right = right + 'px'
    calculateTabsWidthAndPosition: ->
      width = @$el.offsetWidth
      index = 0
      @contentWidth = width * @activeTabNumber + 'px'
      for tabId of @tabList
        tab = @tabList[tabId]
        tab.ref.width = width + 'px'
        tab.ref.left = width * index + 'px'
        index++
    calculateContentHeight: ->
      _this = this
      @$nextTick ->
        if Object.keys(_this.tabList).length
          height = _this.tabList[_this.activeTab].ref.$el.offsetHeight
          _this.contentHeight = height + 'px'
    calculatePosition: ->
      _this2 = this
      window.requestAnimationFrame ->
        _this2.calculateIndicatorPos()
        _this2.calculateTabsWidthAndPosition()
        _this2.calculateContentHeight()
    debounceTransition: ->
      _this3 = this
      window.clearTimeout @transitionControl
      @transitionControl = setTimeout((->
        _this3.calculatePosition()
        _this3.transitionOff = false
      ), 200)
    calculateOnWatch: ->
      @calculatePosition()
      @debounceTransition()
    calculateOnResize: ->
      @transitionOff = true
      @calculateOnWatch()
    setActiveTab: (tabData) ->
      @hasIcons = ! !tabData.icon
      @hasLabel = ! !tabData.label
      @activeTab = tabData.id
      @activeTabNumber = @getTabIndex(@activeTab)
      @calculatePosition()
      @$emit 'change', @activeTabNumber
  mounted: ->
    _this4 = this
    @$nextTick ->
      _this4.observeElementChanges()
      window.addEventListener 'resize', _this4.calculateOnResize
      if Object.keys(_this4.tabList).length and !_this4.activeTab
        firstTab = Object.keys(_this4.tabList)[0]
        _this4.setActiveTab _this4.tabList[firstTab]
  beforeDestroy: ->
    if @parentObserver
      @parentObserver.disconnect()
    window.removeEventListener 'resize', @calculateOnResize

return component
</script>
