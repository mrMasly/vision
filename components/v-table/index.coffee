import Vue from 'vue'
import vTable from './vTable.vue'
import vTableHeader from './vTableHeader.vue'
import vTableFooter from './vTableFooter.vue'
import vTableBody from './vTableBody.vue'
import vTableRow from './vTableRow.vue'
import vTableHead from './vTableHead.vue'
import vTableCell from './vTableCell.vue'
import vTableEdit from './vTableEdit.vue'
import vTableCard from './vTableCard.vue'
import vTableSelect from './vTableSelect.vue'
import vTableAlternateHeader from './vTableAlternateHeader.vue'
import vTablePagination from './vTablePagination.vue'
import vTableTheme from './vTable.theme'

Vue.component 'v-table', vTable
Vue.component 'v-table-header', vTableHeader
Vue.component 'v-table-body', vTableBody
Vue.component 'v-table-footer', vTableFooter
Vue.component 'v-table-row', vTableRow
Vue.component 'v-table-head', vTableHead
Vue.component 'v-table-cell', vTableCell
Vue.component 'v-table-Edit', vTableEdit
Vue.component 'v-table-Select', vTableSelect
Vue.component 'v-table-Card', vTableCard
Vue.component 'v-table-alternate-header', vTableAlternateHeader
Vue.component 'v-table-pagination', vTablePagination


Vue.material.addStyle vTableTheme
