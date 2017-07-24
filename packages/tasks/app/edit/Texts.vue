<template lang="jade">
.l-column
  template(v-if="task.disabled.title")
    v-caption Заголовок
    v-body-1.text {{task.title}}
  template(v-else)
    v-picker(type="textarea" v-model="task.title" label="Заголовок")
  template(v-if="task.disabled.description")
    v-caption Описание
    v-body-1.text(v-html="description")
  template(v-else)
    v-picker(type="textarea" v-model="task.description" label="Описание")
  
</template>

<script lang="coffee">
component =
  name: 'Title'
  props:
    task: Object
  computed:
    description: ->
      return null unless @task.description
      @task.description.replace /\n/g, "<br>"
    
return component
</script>

<style lang="stylus" scoped>
.text
  margin-bottom 12px
</style>