<template lang="jade">
.l-column
  v-toolbar.v-transparent.v-dense.v-shadow
    Add(:params="{date: date}")
  .l-flex.content
    Groups(:groups="groups")
</template>

<script lang="coffee">
import _ from 'lodash'
import Groups from '../Groups.vue'
import Add from '../../add/Add.vue'
component =
  name: 'Day'
  components: { Groups, Add }
  props:
    date: Date
  data: ->
    groups: null
  created: ->
    do @update
  watch:
    date: -> do @update
  methods:
    close: -> @$emit 'close'
    update: ->
      date =
        $gte: moment(@date).startOf('day').toDate()
        $lte: moment(@date).endOf('day').toDate()
      groups = []
      # не выполненные
      groups.push
        name: "Актуальные"
        match:
          date: date
          done: no
      # выполненные
      groups.push
        name: "Выполненные"
        index: 2  
        match:
          $or: [
            {date: date}
            {doneAt: date}
          ]
          done: yes
      @groups = groups
return component
</script>

<style lang="stylus" scoped>
.full-day
  width 500px
  max-width 100%
  min-height 400px
.content
  padding-left 0 !important
  padding-right 0 !important
</style>