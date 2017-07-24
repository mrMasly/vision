import _ from 'lodash'

Meteor.Store.register 'vision.tasks',
  localStorage:
    description: yes
  state:
    group: null
    user: null
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

require './app/data/calendar/store.coffee'