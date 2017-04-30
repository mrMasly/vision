import Vue from 'vue'
import vSidenav from './vSidenav.vue'
import vSidenavTheme from './vSidenav.theme'

Vue.component 'v-sidenav', vSidenav
Vue.material.addStyle vSidenavTheme
