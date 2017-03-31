import Vue from 'vue'
import Vuex from 'vuex'
import _ from 'lodash'
Vue.use(Vuex)

Meteor.Store = window.Store = store = new Vuex.Store
  state:
    components: {}
  mutations:
    linkComponent: (state, data) ->
      state.components[data.id] = data.component

export default store
