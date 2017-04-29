<template lang="jade">
a.md-bottom-bar-item(:href='href', :class='classes', :disabled='disabled', @click='setActive', v-if='href')
  v-icon(v-if='vIcon || vIconSrc || vIconset', :v-icon-src='vIconSrc', :v-iconset='vIconset') {{ vIcon }}
  v-ripple(:v-disabled='disabled')
    span.v-text
      slot

button.v-bottom-bar-item(type='button', :class='classes', :disabled='disabled', @click='setActive', v-else='')
  v-icon(v-if='vIcon || vIconSrc || vIconset', :v-src='vIconSrc', :v-iconset='vIconset') {{ vIcon }}
  v-ripple(:v-disabled='disabled')
    span.v-text
      slot
</template>

<script lang="coffee">
component =
  name: 'v-bottom-bar'
  props:
    vIcon: String
    vIconSrc: String
    vIconset: String
    vActive: Boolean
    disabled: String
    href: String
  data: ->
    active: false
  computed:
    classes: ->
      'v-active': @active
  watch:
    mdActive: (active) ->
      @setActive active

  methods:
    setActive: (active) ->
      if active
        @$parent.setActive this
  mounted: ->
    if !@$parent.$el.classList.contains('md-bottom-bar')
      @$destroy()
      throw new Error('You should wrap the md-bottom-bar-item in a md-bottom-bar')
    if @mdActive
      @active = true

return component
</script>

<style lang="stylus" scoped>
</style>
