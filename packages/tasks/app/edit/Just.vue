<template lang="jade">
v-button.v-icon-button.just(
  :class="{'v-primary': task.just}",
  :disabled="disabled"
  @click.native="toggle")
  v-icon flash_on

</template>

<script lang="coffee">
component =
  name: 'Just'
  props:
    task: Object
  data: ->
    user: Meteor.userId()
  methods:
    toggle: ->
      @task.just = !@task.just
      if @task._id?
        Mongo.Tasks.update @task._id, $set: just: @task.just
  computed:
    disabled: ->
      return no unless @task._id
      return yes if @user isnt @task.for
      return yes if @task.done
      return no

return component
</script>

<style lang="stylus" scoped>
.just
  margin-left 0 !important
  margin-right 0 !important
</style>