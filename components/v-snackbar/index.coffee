import Vue from 'vue'
import vSnackbar from './vSnackbar.vue'
import vSnackbarTheme from './vSnackbar.theme'

Vue.component 'v-snackbar', vSnackbar
Vue.material.addStyle vSnackbarTheme
