<template lang="jade">
button.v-button(:class='[themeClass]', :type='type', :disabled='disabled', v-if='!href')
  v-ripple(:v-disabled='disabled')
  slot
a.v-button(:class='[themeClass]', :href='href', :disabled='disabled', :target='target', :rel='newRel', v-else='')
  v-ripple(:v-disabled='disabled')
  slot
</template>

<script lang="coffee">
import theme from '../../theme/mixin.js'
component =
  name: 'v-button'
  props:
    href: String
    target: String
    rel: String
    type:
      type: String
      default: 'button'
    disabled: Boolean
  mixins: [theme]
  computed:
    newRel: ->
      if @target != '_blank'
        return @rel || 'noopener'
      return @rel


return component
</script>

<style lang="stylus">
</style>
