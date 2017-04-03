import Vue from 'vue'

Plugin = {}

Plugin.install = (vue, options) ->

  vue.mixin
    data: ->
      width: window.innerWidth
      xs: no
      sm: no
      md: no
      lg: no
      xl: no
      gxs: no
      gsm: no
      gmd: no
      glg: no
    methods:
      resize: ->
        @width = window.innerWidth
        @xs = @width < 600
        @sm = 600 <= @width < 960
        @md = 960 <= @width < 1280
        @lg = 1280 <= @width < 1620
        @xl = 1920 <= @width
        @gxs = @width >= 600
        @gsm = @width >= 960
        @gmd = @width >= 1280
        @glg = @width >= 1620
    created: ->
      if @$options.layout
        do @resize
        window.addEventListener 'resize', @resize
    destroyed: ->
      if @$options.layout
        window.removeEventListener 'resize', @resize

Vue.use Plugin
