<template lang="jade">
.v-tab(:id='tabId', :style='styles')
  slot
</template>

<script lang="coffee">

import getClosestVueParent from '../../utils/getClosestVueParent.js'

component =
  name: 'v-tab'
  props:
    id: [String, Number]
    vLabel: [String, Number]
    vIcon: String
    vActive: Boolean
    vDisabled: Boolean
    vTooltip: String
    vTooltipDelay:
      type: String
      default: '0'
    vTooltipDirection:
      type: String
      default: 'bottom'
  data: ->
    mounted: false
    tabId: @id or 'tab-' + Random.id()
    width: '0px'
    left: '0px'
  watch:
    vActive: ->
      @updateTabData()
    vDisabled: ->
      @updateTabData()
    vIcon: ->
      @updateTabData()
    vLabel: ->
      @updateTabData()
    vTooltip: ->
      @updateTabData()
    vTooltipDelay: ->
      @updateTabData()
    vTooltipDirection: ->
      @updateTabData()
  computed:
    styles: ->
      width: @width
      left: @left
  methods:
    getTabData: ->
      id: @tabId
      label: @vLabel
      icon: @vIcon
      active: @vActive
      disabled: @vDisabled
      tooltip: @vTooltip
      tooltipDelay: @vTooltipDelay
      tooltipDirection: @vTooltipDirection
      ref: this
    updateTabData: ->
      @parentTabs.updateTab @getTabData()
  mounted: ->
    tabData = @getTabData()
    @parentTabs = getClosestVueParent(@$parent, 'v-tabs')
    if !@parentTabs
      throw new Error('You must wrap the v-tab in a v-tabs')
    @mounted = true
    @parentTabs.updateTab tabData
    if @vActive
      @parentTabs.setActiveTab tabData
  beforeDestroy: ->
    @parentTabs.unregisterTab @getTabData()


return component
</script>
