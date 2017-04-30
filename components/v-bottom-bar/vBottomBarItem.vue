<template lang="jade">
a.v-bottom-bar-item(:href='href', :class='classes', :disabled='disabled', @click='setActive', v-if='href')
  v-icon(v-if='icon || iconSrc || iconset', :v-icon-src='iconSrc', :v-iconset='iconset') {{ icon }}
  v-ripple(:v-disabled='disabled')
  span.v-text
    slot

button.v-bottom-bar-item(type='button', :class='classes', :disabled='disabled', @click='setActive', v-else='')
  v-icon(v-if='icon || iconSrc || iconset', :v-src='iconSrc', :v-iconset='iconset') {{ icon }}
  v-ripple(:v-disabled='disabled')
  span.v-text
    slot
</template>

<script lang="coffee">
component =
  name: 'v-bottom-bar'
  props:
    icon: String
    iconSrc: String
    iconset: String
    active: Boolean
    disabled: String
    href: String
  data: ->
    active: false
  computed:
    classes: ->
      'v-active': @active
  watch:
    active: (active) ->
      @setActive active

  methods:
    setActive: (active) ->
      if active
        @$parent.setActive this
  mounted: ->
    if !@$parent.$el.classList.contains('v-bottom-bar')
      @$destroy()
      throw new Error('You should wrap the v-bottom-bar-item in a v-bottom-bar')
    if @active
      @active = true

return component
</script>

<style lang="stylus" scoped>
</style>
