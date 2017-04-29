import Vue from 'vue'
import vButtonToggle from './vButtonToggle.vue'
import vButtonToggleTheme from './vButtonToggle.theme'

Vue.component 'v-button-toggle', vButtonToggle
Vue.material.addStyle vButtonToggleTheme
