import Vue from 'vue'
import vAvatar from './vAvatar.vue'
import vAvatarTheme from './vAvatar.theme'

Vue.component 'v-avatar', vAvatar
Vue.material.addStyle vAvatarTheme
