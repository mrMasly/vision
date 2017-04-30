<template lang="jade">
.v-card-media(:class="classes")
  slot
</template>

<script lang="coffee">
component =
  name: 'v-card-media'
  props:
    ratio: String
    medium: Boolean
    big: Boolean
  computed:
    classes: ->
      classes =
        'v-16-9': @ratio == '16:9' or @ratio == '16/9'
        'v-4-3': @ratio == '4:3' or @ratio == '4/3'
        'v-1-1': @ratio == '1:1' or @ratio == '1/1'
      if @medium or @big
        classes =
          'v-medium': @medium
          'v-big': @big
      return classes

return component
</script>
