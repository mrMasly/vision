<template lang="jade">
.v-collapse
  .l-relative
    v-ripple
    v-subheader.v-primary.toggle(
    @click.native="change")
      .l-row.l-start-center
        v-icon(v-if="value") keyboard_arrow_down
        v-icon(v-else) chevron_right
        .l-flex {{label}}
  slot(v-if="value")
</template>

<script lang="coffee">
component =
  name: 'Toggle'
  props:
    value:
      type: Boolean
      required: yes
    label:
      type: String
      required: yes
  methods:
    change: ->
      @$emit 'change', !@value
      @$emit 'input', !@value
  
return component
</script>