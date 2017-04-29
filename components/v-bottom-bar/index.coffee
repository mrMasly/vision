import Vue from 'vue'
import vBottomBar from './vBottomBar.vue'
import vBottomBarItem from './vBottomBarItem.vue'
import vBottomBarTheme from './vBottomBar.theme'

Vue.component 'v-bottom-bar', vBottomBar
Vue.component 'v-bottom-bar-item', vBottomBarItem
Vue.material.addStyle vBottomBarTheme
