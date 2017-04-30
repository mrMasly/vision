import Vue from 'vue'
import vTabs from './vTabs.vue'
import vTab from './vTab.vue'
import vTabsTheme from './vTabs.theme'

Vue.component 'v-tabs', vTabs
Vue.component 'v-tab', vTab
Vue.material.addStyle vTabsTheme
