import Vue from 'vue'
import _ from 'lodash'

Plugin = {}

created = ->
  return null unless @$options.route?.params?
  routes = @$options.route.params
  @$router.beforeEach (to, from, next) =>
    if to.name isnt @$options.route.name
      do next
    else
      update to, routes, next, @$router, @$refs
      do next

mounted = ->
  return null unless @$options.route?.params?
  setTimeout =>
    routes = @$options.route.params
    $refs = @$refs
    $route = @$route
    $router = @$router
    update @$route, routes, null, @$router, @$refs

    _.forIn routes, (options, param) =>

      ref = @$refs[options.ref]
      if options.type is 'tabs'

        ref.$on 'change', =>
          tabIndex = ref.getTabIndex ref.activeTab
          newRoute =
            params: _.clone Meteor.Vue.$route.params
            name: $route.name
            query: _.clone Meteor.Vue.$route.query
          newRoute.params[param] = options.data[tabIndex]
          $router.push newRoute

      else if options.type is 'dialog'
        ref.$on 'close', (e) ->
          route = _.clone Meteor.Vue.$route
          if Meteor.Vue.$route.params[param]?
            route.params[param] = null
            $router.push route


        ref.$on 'open', ->
          setTimeout =>
            ref.$el.focus()
          , 100

  , 100
destroyed = ->
  return null unless @$options.routes?



# когда происходит изменения роута
update = ($route, routes, next, $router, $refs) ->
  _.forIn routes, (options, param) =>

    # если какого-то параметра нет - но есть по-умолчанию
    if options.default and not $route.params[param]?
      newRoute =
        params: _.clone $route.params
        name: $route.name
        query: _.clone $route.query
      newRoute.params[param] = options.default
      if next?
        return next newRoute
      else if $router?
        return $router.push newRoute

    ref = $refs[options.ref]

    return null unless ref?


    if options.type is 'tabs'

      tabs = _.values ref.tabList
      index = _.indexOf options.data, $route.params[param]
      return if index is ref.activeTabNumber
      tab = tabs[index]
      ref.setActiveTab tab
    else if options.type is 'dialog'
      if $route.params[param]? then ref.open()
      else
        ref.close()


Plugin.install = (vue, options) ->

  vue.mixin
    created: created
    mounted: mounted
    destroyed: destroyed


Vue.use Plugin
