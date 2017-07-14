<template lang="jade">
.priority(v-if="task.priority != 1", :style="{color: color}") {{ text }}
</template>

<script lang="coffee">
component =
  name: 'Priority'
  props:
    task: Object
  computed:
    text: ->
      switch @task.priority
        when 0 then '!'
        when 2 then '!!'
        when 3 then '!!!'
    color: ->
      switch @task.priority
        when 0 then '#0f0'
        when 2 then '#e4b900'
        when 3 then '#f00'
return component
</script>

<style lang="stylus" scoped>
.priority
  margin-right 4px
</style>