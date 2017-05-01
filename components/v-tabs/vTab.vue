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
    label: [String, Number]
    icon: String
    active: Boolean
    disabled: Boolean
    tooltip: String
    tooltipDelay:
      type: String
      default: '0'
    tooltipDirection:
      type: String
      default: 'bottom'
    name: String
  data: ->
    mounted: false
    tabId: @id or 'tab-' + Random.id()
    width: '0px'
    left: '0px'
  watch:
    active: ->
      @updateTabData()
    disabled: ->
      @updateTabData()
    icon: ->
      @updateTabData()
    label: ->
      @updateTabData()
    tooltip: ->
      @updateTabData()
    tooltipDelay: ->
      @updateTabData()
    tooltipDirection: ->
      @updateTabData()
  computed:
    styles: ->
      width: @width
      left: @left
  methods:
    getTabData: ->
      id: @tabId
      label: @label
      icon: @icon
      active: @active
      disabled: @disabled
      tooltip: @tooltip
      tooltipDelay: @tooltipDelay
      tooltipDirection: @tooltipDirection
      ref: this
      name: @name
    updateTabData: ->
      @parentTabs.updateTab @getTabData()
  mounted: ->
    tabData = @getTabData()
    @parentTabs = getClosestVueParent(@$parent, 'v-tabs')
    if !@parentTabs
      throw new Error('You must wrap the v-tab in a v-tabs')
    @mounted = true
    @parentTabs.updateTab tabData
    if @active
      @parentTabs.setActiveTab tabData
  beforeDestroy: ->
    @parentTabs.unregisterTab @getTabData()


return component
</script>
