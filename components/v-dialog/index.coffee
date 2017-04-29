import Vue from 'vue'
import vDialog from './vDialog.vue'
import vDialogTitle from './vDialogTitle.vue'
import vDialogContent from './vDialogContent.vue'
import vDialogActions from './vDialogActions.vue'
import vDialogAlert from './vDialogAlert.vue'
import vDialogConfirm from './vDialogConfirm.vue'
import vDialogPrompt from './vDialogPrompt.vue'
import vDialogTheme from './vDialog.theme'

Vue.component 'v-dialog', vDialog
Vue.component 'v-dialog-title', vDialogTitle
Vue.component 'v-dialog-content', vDialogContent
Vue.component 'v-dialog-actions', vDialogActions
Vue.component 'v-dialog-alert', vDialogAlert
Vue.component 'v-dialog-confirm', vDialogConfirm
Vue.component 'v-dialog-prompt', vDialogPrompt
Vue.material.addStyle vDialogTheme
