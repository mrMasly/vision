import Vue from 'vue'
import vRadio from './vRadio.vue'
import vRadioTheme from './vRadio.theme'

Vue.component 'v-radio', vRadio
Vue.material.addStyle vRadioTheme
