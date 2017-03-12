import Vue from 'vue'
import Vuex from 'vuex'
import _ from 'lodash'

Vue.use(Vuex)

window.Store = store = new Vuex.Store
  state:
    routes: []
    tabs: []
    tab: null
  mutations:
    addRoute: (state, route) ->
      Router.configure (r) ->
        r.addRoute
          path: route.path
          component: route.component
          name: route.name
        state.routes = _.reject state.routes, name: route.name
        state.routes = _.concat state.routes, route
    selectTab: (state, route) ->
      _route = _.find state.routes, name: route.name
      state.tabs = _.map state.tabs, (tab) ->
        tab.active = tab.name is _route.tab
        state.tab = tab if tab.active
        return tab

    rememberTab: (state, route) ->
      path = route.path
      _route = _.find state.routes, name: route.name
      tab = _.find state.tabs, name: _route.tab
      tab.route = path: path
      state.tabs = [state.tabs...]
    addTab: (state, tab) ->
      tabs = _.reject state.tabs, name: tab.name
      tab.active ?= no
      tabs.push tab
      state.tabs = tabs

export default store
