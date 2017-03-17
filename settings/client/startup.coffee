import Vue from 'vue'
import Vision from '../../app/Vision.vue'
import Login from '../../app/Login.vue'
import router from './router.coffee'
import store from '../../store/index.coffee'

metaInfo =
  title: 'Vision'
  meta: [
    { charset: 'utf-8' },
    { name: 'viewport', content: 'width=device-width, initial-scale=1' }
    { name: 'apple-mobile-web-app-capable', content: 'yes' }
  ]
  link: [
    {rel: 'stylesheet', href: '//fonts.googleapis.com/css?family=Roboto:300,400,500,700,400italic'}
    {rel: 'stylesheet', href: '//fonts.googleapis.com/icon?family=Material+Icons'}
    {rel: 'icon', href: '/packages/mrmasly_vision/files/icon.png', type: 'image/png' }
  ]


Meteor.startup ->
  _metaInfo = _.clone metaInfo
  _metaInfo.title = 'Войдите'
  Meteor.app = new Vue
    render: (h) -> h Vision
    router: router.start()
    store: store
    metaInfo: metaInfo
  Meteor.app.startup = ->
    Meteor.subscribe '--users--groups--', ->
      Meteor.app.$mount 'app'
  Meteor.login = new Vue
    render: (h) -> h Login
    metaInfo: _metaInfo


  if Meteor.userId() then Meteor.app.startup()
  else Meteor.login.$mount 'app'
