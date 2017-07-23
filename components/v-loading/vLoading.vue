<template lang="jade">
transition(name="vloading")
  slot.v-loading-child(v-if="!loading")
  .v-loading.v-loading-child(v-else)
    svg.circular(viewbox='25 25 50 50')
      circle.path(cx='50', cy='50', r='20', fill='none', stroke-width='2', stroke-miterlimit='10')
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'vLoading'
  watch:
    value: ->
      do @check
  props:
    value: required: no
    color:
      type: String
      default: '#fff'
  data: ->
    loading: yes
  created: ->
    @check = _.throttle @check, 500
    do @check
  methods:
    check: ->
      @loading = !@value
      if @value then @$emit 'load'
  computed:
    styles: ->
      backgroundColor: @color

return component
</script>
