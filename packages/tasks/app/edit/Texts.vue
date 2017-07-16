<template lang="jade">
.l-column
  v-picker(type="textarea" v-model="task.title" label="Заголовок")
  v-picker(type="textarea" v-model="task.description" label="Описание")
</template>

<script lang="coffee">
component =
  name: 'Title'
  props:
    task: Object
    
return component
</script>

<style lang="stylus" scoped>
</style>