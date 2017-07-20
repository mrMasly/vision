<template lang="jade">
.full-day.l-column
  v-toolbar.l-row.l-space-between
    v-title.l-flex {{date | moment}}
    v-button.v-icon-button(@click.native="close")
      v-icon close
  v-toolbar.v-transparent.v-dense.v-shadow
    Add(:date="date")
  v-dialog-content.l-flex.content
    Groups(:groups="groups")
</template>

<script lang="coffee">
import _ from 'lodash'
import Groups from '../Groups.vue'
import Add from '../../add/Add.vue'
component =
  name: 'FullDay'
  components: { Groups, Add }
  data: ->
    groups = []
    date =
      $gte: moment(@date).startOf('day').toDate()
      $lte: moment(@date).endOf('day').toDate()
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
    
    return { groups }
  props:
    date: Date
  methods:
    close: -> @$emit 'close'
      
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