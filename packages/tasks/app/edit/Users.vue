<template lang="jade">
.l-column(v-if="!task.from")
  v-input-container
    label Исполнитель
    v-select(v-model="task.users" multiple search)
      v-option(v-for="user in users", :value="user._id") {{user.profile.name}}
  v-picker(type="select" v-model="task.disables" label="Запретить менять" v-if="task.users.length" multiple)
    v-option(v-for="dis in disables", :key="dis.id", :value="dis.id") {{dis.name}}
  
  template(v-if="task.createdAt")
    .l-margin
    v-caption Выполнение:
    .user.l-row(v-for="t in usersTasks")
      v-checkbox(disabled v-model="t.done")
      .l-flex {{ t.userName }}
      .subs(v-if="t._subs") {{t._subs.completed}}/{{t._subs.all}}
</template>

<script lang="coffee">
import _ from 'lodash'
component =
  name: 'users'
  data: ->
    search: ''
  props:
    task: Object
  data: ->
    disables: [
      { id: 'date', name: 'Дату' }
      { id: 'time', name: 'Время' }
      { id: 'priority', name: 'Приоритет' }
      { id: 'subs', name: 'Подзадачи' }
      { id: 'title', name: 'Название' }
      { id: 'description', name: 'Описание' }
    ]
  meteor:
    server:
      publish:
        users: -> Mongo.Users.find {}, fields:
          'profile.name': 1
          'username': 1
        usersTasks: (parentId) ->
          Mongo.Tasks.find parent: parentId
    subscribe:
      users: []
      usersTasks: -> [@task._id]
    users: -> Mongo.Users.find _id: $ne: Meteor.userId()
    usersTasks:
      params: -> @task._id
      update: (parentId) -> Mongo.Tasks.find {parent: parentId}, transform: (doc) ->
        doc.userName = Meteor.users.findOne(doc.for)?.profile?.name
        unless _.isEmpty doc.subs
          doc._subs =
            all: doc.subs.length
            completed: _.size _.filter(doc.subs, done: yes)
        return doc
return component
</script>

<style lang="stylus" scoped>
.v-checkbox
  margin 0 4px !important
</style>
