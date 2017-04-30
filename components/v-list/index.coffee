import Vue from 'vue'
import vList from './vList.vue'
import vListItem from './vListItem.vue'
import vListExpand from './vListExpand.vue'
import vListTheme from './vList.theme'

Vue.component 'v-list', vList
Vue.component 'v-list-item', vListItem
Vue.component 'v-list-expand', vListExpand
Vue.material.addStyle vListTheme
