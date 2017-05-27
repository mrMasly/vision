import Vue from 'vue'
import vDropzone from './vDropzone.vue'
if Meteor.isClient
  require 'dropzone/dist/dropzone.css'

Vue.component 'v-dropzone', vDropzone
