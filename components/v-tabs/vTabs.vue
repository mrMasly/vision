<template lang="jade">
.v-tabs(:class='[themeClass, tabClasses]')
  nav.v-tabs-navigation(:class='navigationClasses', ref='tabNavigation')
    button.v-tab-header(v-for='header in tabList', :key='header.id', type='button', :class='getHeaderClass(header)', :disabled='header.disabled', @click='setActiveTab(header)', ref='tabHeader')
      v-ripple(:disabled='header.disabled')
      .v-tab-header-container
        v-icon(v-if='header.icon') {{ header.icon }}
        span(v-if='header.label') {{ header.label }}
        v-tooltip(v-if='header.tooltip', :direction='header.tooltipDirection', :delay='header.tooltipDelay') {{ header.tooltip }}
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
    fixed: Boolean
    centered: Boolean
    right: Boolean
    dynamicHeight:
      type: Boolean
      default: true
    elevation:
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
      'v-dynamic-height': @dynamicHeight
      'v-transition-off': @transitionOff
    navigationClasses: ->
      'v-has-icon': @hasIcons
      'v-has-label': @hasLabel
      'v-fixed': @fixed
      'v-right': !@centered and @right
      'v-centered': @centered or @fixed
    indicatorClasses: ->
      toLeft = @lastIndicatorNumber > @activeTabNumber
      @lastIndicatorNumber = @activeTabNumber
      return {
        'v-transition-off': @transitionOff
        'v-to-right': !toLeft
        'v-to-left': toLeft
      }
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
      @$nextTick ->
        if Object.keys(@tabList).length
          height = @tabList[@activeTab].ref.$el.offsetHeight
          @contentHeight = height + 'px'
    calculatePosition: ->
      window.requestAnimationFrame =>
        @calculateIndicatorPos()
        @calculateTabsWidthAndPosition()
        @calculateContentHeight()
    debounceTransition: ->
      window.clearTimeout @transitionControl
      @transitionControl = setTimeout((=>
        @calculatePosition()
        @transitionOff = false
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
    @$nextTick ->
      @observeElementChanges()
      window.addEventListener 'resize', @calculateOnResize
      if Object.keys(@tabList).length and !@activeTab
        firstTab = Object.keys(@tabList)[0]
        @setActiveTab @tabList[firstTab]
  beforeDestroy: ->
    if @parentObserver
      @parentObserver.disconnect()
    window.removeEventListener 'resize', @calculateOnResize

return component
</script>
