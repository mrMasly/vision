import Vue from 'vue'
import vCheckbox from './vCheckbox.vue'
import vCheckboxTheme from './vCheckbox.theme'

Vue.component 'v-checkbox', vCheckbox
Vue.material.addStyle vCheckboxTheme
