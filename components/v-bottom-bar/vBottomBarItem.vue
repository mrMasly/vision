<template lang="jade">
a.v-bottom-bar-item(:href='href', :class='classes', :disabled='disabled', @click='setActive', v-if='href')
  v-icon(v-if='icon || iconSrc || iconset', :icon-src='iconSrc', :iconset='iconset') {{ icon }}
  v-ripple(:disabled='disabled')
  span.text
    slot

button.v-bottom-bar-item(type='button', :class='classes', :disabled='disabled', @click='setActive', v-else)
  v-icon(v-if='icon || iconSrc || iconset', :src='iconSrc', :iconset='iconset') {{ icon }}
  v-ripple(:disabled='disabled')
  span.text
    slot
</template>

<script lang="coffee">
component =
  name: 'v-bottom-bar-item'
  props:
    icon: String
    iconSrc: String
    iconset: String
    active:
      type: Boolean
      default: false
    disabled: String
    href: String
  data: ->
    localActive: false
  computed:
    classes: ->
      'v-active': @localActive
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
      @localActive = true

return component
</script>
