import Vue from 'vue'
import vSpinner from './vSpinner.vue'
import vSpinnerTheme from './vSpinner.theme'

Vue.component 'v-spinner', vSpinner
Vue.material.addStyle vSpinnerTheme
