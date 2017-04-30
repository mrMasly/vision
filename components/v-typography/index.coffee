import Vue from 'vue'

names = [
  'v-content'
  'v-caption'
  'v-body-1'
  'v-body-2'
  'v-subheading'
  'v-title'
  'v-headline'
  'v-display-1'
  'v-display-2'
  'v-display-3'
  'v-display-4'
]

names.forEach (name) ->
  Vue.component name,
    render: (createElement) ->
      createElement 'div', {class: name}, @$slots.default
