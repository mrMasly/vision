import Vue from 'vue'
import vButton from './vButton.vue'
import vButtonTheme from './vButton.theme'

Vue.component 'v-button', vButton
Vue.material.addStyle vButtonTheme
