<template lang="jade">
v-input-container
  label {{label}}
  template(v-if="type=='select'")
    v-select(v-model="val" @input="input" @change="change",
    :multiple="multiple", :search="search", :height="height", :width="width",
    :disabled="disabled")
      slot
  template(v-else-if="type=='calendar'")
    v-calendar(v-model="val" @input="input" @change="change",
    :disabled="disabled" period="period")
  template(v-else-if="type=='textarea'")
    v-textarea(v-model="val" @input="input" @change="change",
    :disabled="disabled")
  template(v-else)
    v-input(v-model="val" @input="input" @change="change",
    :disabled="disabled")

</template>

<script lang="coffee">
component =
  name: 'v-picker'
  data: ->
    val: @value
  props:
    label: String
    type:
      type: String
      default: 'text'
    value:
      required: yes
    disabled: Boolean
    # select
    multiple: [String, Boolean]
    search: [String, Boolean]
    height: [String, Number]
    width: [String, Number]
    # calendar
    period: Boolean



  methods:
    input: (val) -> @$emit 'input', val
    change: (val) -> @$emit 'change', val


return component
</script>
