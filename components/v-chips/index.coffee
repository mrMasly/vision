import Vue from 'vue'
import vChips from './vChips.vue'
import vChip from './vChip.vue'
import vChipsTheme from './vChips.theme'

Vue.component 'v-chips', vChips
Vue.component 'v-chip', vChip
Vue.material.addStyle vChipsTheme
