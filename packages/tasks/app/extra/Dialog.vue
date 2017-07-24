<template lang="jade">
v-dialog(ref="dialog" query-param="task" v-if="$route.name!='tasks'")
  Edit.edit(v-model="task" save-on-enter, :fabs="false", :actions="true"
    @close="close" @save="close" v-if="task")
</template>

<script lang="coffee">
import Edit from '../edit/Edit.vue'
component =
  name: 'TaskDialog'
  components: { Edit }
  dialog: yes
  methods:
    close: -> @$refs.dialog.close()
  meteor:
    server:
      publish:
        task: (id) -> Mongo.Tasks.find _id: id
    subscribe:
      task: -> [@$route.query.task]
    task:
      params: -> @$route.query.task
      update: (id) ->
        task = Mongo.Tasks.findOne _id: id
        return task

return component
</script>

<style lang="stylus" scoped>
.edit
  width 400px
  height 600px
  max-width 100%
  max-height 100%
</style>