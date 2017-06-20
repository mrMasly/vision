<template lang="jade">
.v-collapse
  .l-relative
    v-ripple
    v-subheader.v-primary.toggle(
    @click.native="data[prop]=!data[prop]")
      .l-row.l-start-center
        v-icon(v-if="data[prop]") keyboard_arrow_down
        v-icon(v-else) chevron_right
        .l-flex {{label}}
  slot(v-if="data[prop]")
</template>

<script lang="coffee">
component =
  name: 'Toggle'
  props:
    data:
      type: Object
      required: yes
    label:
      type: String
      required: yes
    prop:
      type: String
      default: 'toggle'

return component
</script>