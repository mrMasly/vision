import Vue from 'vue'
import Vuex from 'vuex'
import _ from 'lodash'
Vue.use(Vuex)

Meteor.Store = new Vuex.Store
  modules:
    vision:
      namespaced: yes
      state:
        components: {}
      mutations:
        linkComponent: (state, data) ->
          state.components[data.id] = data.component

export default Meteor.Store
