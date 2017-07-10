<template lang="jade">
.v-collapse.v-shadow
  .l-relative
    v-ripple
    v-subheader.v-primary.toggle(
    @click.native="change")
      .l-row.l-start-center
        v-icon(v-if="value") keyboard_arrow_down
        v-icon(v-else) chevron_right
        .l-flex
          slot(name="label" v-if="$slots.label")
          div(v-else) {{label}}
  .l-padding(v-if="value")
    slot
</template>

<script lang="coffee">
component =
  name: 'Toggle'
  props:
    value:
      type: Boolean
      required: yes
    label: String
      
  methods:
    change: ->
      @$emit 'change', !@value
      @$emit 'input', !@value
  
return component
</script>