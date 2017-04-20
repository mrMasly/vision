<template lang="jade">
.l-column
  .l-padding
    Dates(:task="task")
    Priority(:task="task")
    Users(:task="task")
  .l-row.actions.l-end
    md-button.md-primary(@click.native="close") Отмена
    md-button.md-primary(@click.native="save") Сохранить
</template>

<script lang="coffee">
import Dates from './Dates.vue'
import Priority from './Priority.vue'
import Users from './Users.vue'
import Tags from './Tags.vue'
component =
  name: 'settings'
  components: { Dates, Priority, Users, Tags }
  props:
    task: Object
  methods:
    close: -> @$emit 'close'
    save: ->
      if @task._id
        Mongo.Tasks.update @task._id, $set:
          date: @task.date
          time: @task.time
          priority: @task.priority
          repeat: @task.repeat
      @$emit 'save'
      do @close
return component
</script>

<style lang="stylus" scoped>
.md-divider
  margin 8px 0
</style>
