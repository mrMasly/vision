<template lang="jade">
.l-column
  date-toolbar(v-model="date")
    div(slot="left")
      slot
  .l-flex.l-relative
    .l-fill.l-absolute
      Groups(:groups="groups")
      //- v-loading(:value="$subReady.tasks && tasks")
      //-   .l-scroll.list
      //-     Task(v-for="task in tasks", :task="task", :key="task._id")
</template>

<script lang="coffee">
import Groups from './Groups.vue'
# import Task from './Task.vue'
component =
  name: 'Doned'
  components: { Groups }
  data: ->
    date: new Date
    groups: []
  created: -> do @update
  watch:
    date: -> do @update
  methods:
    update: ->
      @groups = []
      @groups.push
        name: 'Выполненные'
        match:
          done: yes
          doneAt:
            $gte: moment(@date).startOf('day').toDate()
            $lte: moment(@date).endOf('day').toDate()

return component
</script>

<style lang="stylus" scoped>
.list
  padding-top 18px
</style>