import Vue from 'vue'
import vSwitch from './vSwitch.vue'
import vSwitchTheme from './vSwitch.theme'

Vue.component 'v-switch', vSwitch
Vue.material.addStyle vSwitchTheme
