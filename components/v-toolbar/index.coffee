import Vue from 'vue'
import vToolbar from './vToolbar.vue'
import vToolbarTheme from './vToolbar.theme'

Vue.component 'v-toolbar', vToolbar
Vue.material.addStyle vToolbarTheme
