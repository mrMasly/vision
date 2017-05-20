<template lang="jade">
td.v-table-select
  v-select(v-model="val" @change="change" @input="input")
    slot
    div(slot="value" style="text-align:center" v-if="!value") ...
</template>

<script lang="coffee">
component =
  name: 'vTableSelect'
  props:
    value: [String, Array]
  data: ->
    val: @value
  watch:
    value: -> @val = @value
  methods:
    change: (val) -> @$emit 'change', val
    input: (val) -> @$emit 'input', val

return component
</script>

<style lang="stylus" scoped>
</style>
