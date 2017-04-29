import Vue from 'vue'
import vIcon from './vIcon.vue'
import vIconTheme from './vIcon.theme'

Vue.component 'v-icon', vIcon
Vue.material.addStyle vIconTheme
