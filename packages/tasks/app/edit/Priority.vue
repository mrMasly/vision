<template lang="jade">
.priority(:class="{hover: hover}")
  template(v-if="task.disabled.priority")
    v-button.v-icon-button.v-mini(fab-trigger @click.native="select(1)")
      .v-icon(style="font-size:1.3em", :style="{color: priority.color}") {{priority.text}}
  .absolute(v-else)
    v-speed-dial.v-button-icon.v-mini(open='hover' direction="right" ref="dial" @trigger="hover=arguments[0]")
      v-button.v-icon-button.v-mini(fab-trigger @click.native="select(1)")
        v-icon(icon-morph) close
        .v-icon(style="font-size:1.3em", :style="{color: priority.color}") {{priority.text}}
      v-button.v-fab.v-mini.v-clean(:style="{color: '#0f0'}" @click.native="select(0)")
        span(style="font-size:1.3em") !
        v-tooltip(direction="bottom") низкий приоритет
      v-button.v-fab.v-mini.v-clean(:style="{color: '#e4b900'}" @click.native="select(2)")
        span(style="font-size:1.3em") !!
        v-tooltip(direction="bottom") средний приоритет
      v-button.v-fab.v-mini.v-clean(:style="{color: '#f00'}" @click.native="select(3)")
        span(style="font-size:1.3em") !!!
        v-tooltip(direction="bottom") высокий приоритет
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'priority'
  props:
    task: Object
  data: ->
    types: [
      { name: 'обычный', value: 1, color: '#000', text: '!' }
      { name: 'низкий',  value: 0, color: '#0f0', text: '!' }
      { name: 'средний', value: 2, color: '#e4b900', text: '!!' }
      { name: 'высокий', value: 3, color: '#f00', text: '!!!' }
    ]
    hover: no
  methods:
    select: (val) ->
      @hover = no
      @task.priority = val
      @$refs.dial.off()
  computed:
    priority: -> _.find @types, value: @task.priority

return component
</script>

<style lang="stylus" scoped>

.priority
  overflow hidden
  z-index 2
  position relative
  width 40px
  height 40px
  &.hover
    overflow visible
.absolute
  width 220px
</style>
