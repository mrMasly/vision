<template lang="jade">
.v-card-media(:class="classes")
  slot
</template>

<script lang="coffee">
component =
  name: 'v-card-media'
  props:
    vRatio: String
    vMedium: Boolean
    vBig: Boolean
  computed:
    classes: ->
      classes =
        'v-16-9': @vRatio == '16:9' or @vRatio == '16/9'
        'v-4-3': @vRatio == '4:3' or @vRatio == '4/3'
        'v-1-1': @vRatio == '1:1' or @vRatio == '1/1'
      if @vMedium or @vBig
        classes =
          'v-medium': @vMedium
          'v-big': @vBig
      return classes

return component
</script>
