import Vue from 'vue'
import Vision from '../../app/Vision.vue'
import router from './router.coffee'
import store from '../../store/index.coffee'


Meteor.startup ->
  Meteor.vue = new Vue
    render: (h) -> h Vision
    router: router.start()
    store: store
    metaInfo:
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
  .$mount 'app'
