import _ from 'lodash'

Meteor.Store.registerModule ['vision', 'tasks'],
  namespaced: yes
  state:
    group: null
    user: null
    options: [ 'group' ]
  mutations:
    setGroup: (state, group) ->
      state.group = group
    setUser: (state, userId) ->
      state.user = userId
    toggleOption: (state, option) ->
      if option in state.options
        state.options = _.without state.options, option
      else
        state.options.push option
