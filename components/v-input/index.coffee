import Vue from 'vue'
import vInputContainer from './vInputContainer.vue'
import vInput from './vInput.vue'
import vTextarea from './vTextarea.vue'
import vInputContainerTheme from './vInputContainer.theme'

Vue.component 'v-input-container', vInputContainer
Vue.component 'v-input', vInput
Vue.component 'v-textarea', vTextarea
Vue.material.addStyle vInputContainerTheme
