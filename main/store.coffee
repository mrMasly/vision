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



Meteor.Store.register = (name, params) ->
  unless _.isArray name
    name = name.split '.'
  _name = name.join '.'
  params.namespaced = yes
  params.state ?= {}

  ['localStorage', 'sessionStorage'].forEach (type) ->
    if params[type]?
      for key, val of params[type]
        do ->
          # пробуем получить значение из localStorage
          if Meteor.isClient
            _key = _name+'.'+key
            newVal = window[type].getItem "vuex."+_key
            if newVal?
              newVal = JSON.parse newVal
              if _.isObject val
                val = _.merge val, newVal
              else
                val = newVal
          params.state[key] = _.clone val
          Meteor.startup ->

            Meteor.Store.watch ((state) -> _.get state, _key), (val) ->
              json = JSON.stringify val
              window[type].setItem "vuex."+_key, json
            , deep: yes

  Meteor.Store.registerModule name, params
