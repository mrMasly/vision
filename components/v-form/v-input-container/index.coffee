import Vue from 'vue'
import vInputContainer from './vInputContainer.vue'
import vInputContainerTheme from './vInputContainer.theme'

Vue.component 'v-input-container', vInputContainer
Vue.material.addStyle vInputContainerTheme
