<template lang="jade">
transition(name="fade")
  slot.v-loading-child(v-if="!loading")
  .v-loading.v-loading-child(v-else)
    svg.circular(viewbox='25 25 50 50')
      circle.path(cx='50', cy='50', r='20', fill='none', stroke-width='2', stroke-miterlimit='10')
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'vLoading'
  watch:
    value: ->
      do @check
  props:
    value: required: no
    color:
      type: String
      default: '#fff'
  data: ->
    loading: yes
  created: ->
    @check = _.throttle @check, 500
    do @check
  methods:
    check: -> @loading = !@value
  computed:
    styles: ->
      backgroundColor: @color


return component
</script>

<style lang="stylus" scoped>
.fade-enter-active
.fade-leave-active
  transition: opacity .5s
.fade-enter
.fade-leave-to
  opacity  0

.v-loading-child
  position absolute
  top 0
  left 0
  width 100%
  height 100%
.v-loading
  display flex
  align-content center
  align-items center
  justify-content center

.loader {
  position: absolute;
  width: 100px;
  height: 100px;
  left: 50%;
  top: 20%;
}

.circular {
  animation: rotate 2s linear infinite;
  height: 100px;
  position: relative;
  width: 100px;
}

.path {
  stroke-dasharray: 1,200;
  stroke-dashoffset: 0;
  animation: dash 1.5s ease-in-out infinite, color 6s ease-in-out infinite;
  stroke-linecap: round;
}

@keyframes rotate {
  100% {
    transform: rotate(360deg);
  }
}
@keyframes dash {
  0% {
    stroke-dasharray: 1,200;
    stroke-dashoffset: 0;
  }
  50% {
    stroke-dasharray: 89,200;
    stroke-dashoffset: -35;
  }
  100% {
    stroke-dasharray: 89,200;
    stroke-dashoffset: -124;
  }
}
@keyframes color {
  100%, 0% {
    stroke: #d62d20;
  }
  40% {
    stroke: #0057e7;
  }
  66% {
    stroke: #008744;
  }
  80%, 90% {
    stroke: #ffa700;
  }
}

</style>