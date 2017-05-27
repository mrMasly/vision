import Vue from 'vue'
import _ from 'lodash'
Nodes = []
started = no
cbs = []

Meteor.startup ->
  do cb for cb in cbs
  started = yes

make = (cb) ->
  if started then do cb
  else cbs.push cb

Vue.directive 'print',
  bind: (el, binding, vnode) ->
    vnode.__id = Random.id()
    make -> setTimeout ->
      Nodes.push vnode
      $(el).addClass('v-print-prepend-body').prependTo($('body'))
      do update

  unbind: (el, binding, vnode) ->
    $(el).remove()
    Nodes = _.reject Nodes, __id: vnode.__id
    do update

update = ->

  # if Nodes.length is 0
  #   $('#vision').removeClass 'no-print'
  # else
  #   $('#vision').addClass 'no-print'
  for node, index in Nodes
    if index is Nodes.length-1
      $(node.elm).removeClass 'no-print'
    else
      $(node.elm).addClass 'no-print'
