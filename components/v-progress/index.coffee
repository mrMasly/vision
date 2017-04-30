import Vue from 'vue'
import vProgress from './vProgress.vue'
import vProgressTheme from './vProgress.theme'

Vue.component 'v-progress', vProgress
Vue.material.addStyle vProgressTheme
