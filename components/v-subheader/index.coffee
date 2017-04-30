import Vue from 'vue'
import vSubheader from './vSubheader.vue'
import vSubheaderTheme from './vSubheader.theme'

Vue.component 'v-subheader', vSubheader
Vue.material.addStyle vSubheaderTheme
