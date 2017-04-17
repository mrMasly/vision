Meteor.Store.registerModule ['vision', 'tasks'],
  namespaced: yes
  state:
    group: null
    user: Meteor.userId()
    options: {}
  mutations:
    setGroup: (state, group) ->
      state.group = group
    setUser: (state, userId) ->
      state.user = userId
