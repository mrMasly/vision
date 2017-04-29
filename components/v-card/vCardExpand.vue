<template lang="jade">
.v-card-expand(ref="expand")
  slot
</template>

<script lang="coffee">
component =
  name: 'v-card-expand'
  methods:
    setContentMargin: ->
      @content.style.marginTop = -@content.offsetHeight + 'px'
    toggle: ->
      @$refs.expand.classList.toggle 'v-active'
    onWindowResize: ->
      window.requestAnimationFrame @setContentMargin
  mounted: ->
    setTimeout =>
      @trigger = @$el.querySelector('[v-expand-trigger]')
      @content = @$el.querySelector('.v-card-content')
      if @content
        @setContentMargin()
        @trigger.addEventListener 'click', @toggle
        window.addEventListener 'resize', @onWindowResize
    , 200
    return
  destroyed: ->
    if @content
      @trigger.removeEventListener 'click', @toggle
      window.removeEventListener 'resize', @onWindowResize

return component
</script>
