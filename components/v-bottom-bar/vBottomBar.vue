<template lang="jade">
.v-bottom-bar(:class='[themeClass, classes]')
  slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
import {findIndex} from 'lodash'
component =
  name: 'v-bottom-bar'
  props:
    vShift: Boolean
  mixins: [theme]
  computed:
    classes: -> if @vShift then 'v-shift' else 'v-fixed'
  methods:
    setActive: (item) ->
      for child in @$children
        child.active = child is item
      @$emit 'change', findIndex @$children, (i) => i is item

return component
</script>
