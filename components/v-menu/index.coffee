import Vue from 'vue'
import vMenu from './vMenu.vue'
import vMenuContent from './vMenuContent.vue'
import vMenuItem from './vMenuItem.vue'
import vMenuTheme from './vMenu.theme'

Vue.component 'v-menu', vMenu
Vue.component 'v-menu-content', vMenuContent
Vue.component 'v-menu-item', vMenuItem
Vue.material.addStyle vMenuTheme
