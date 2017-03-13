import _ from 'lodash'

FS.Store.Size = (width, height) ->
  _width = _.toString width
  _height = _.toString height
  name = "#{_width}x#{_height}"
  if Meteor.isClient
    new FS.Store.FileSystem name
  else
    new FS.Store.FileSystem name,
      path: Meteor.root+"/../files/cfs/#{name}/"
      transformWrite: (file, readStream, writeStream) ->
        gm readStream, file.name()
          .resize width, height, '!'
          .stream()
          .pipe writeStream

FS.Resize = (dir, name, width, height) ->
  if Meteor.isClient
    new FS.Store.FileSystem "#{dir}/#{name}"
  else
    new FS.Store.FileSystem "#{dir}/#{name}",
      path: Meteor.root+"/../files/fs/#{dir}/#{name}/"
      transformWrite: (file, readStream, writeStream) ->
        gm readStream, file.name()
          .resize height, width
          .stream()
          .pipe writeStream

Mongo.Avatars = new FS.Collection 'avatars',
  stores: [
    FS.Store.Size 50, 50
    FS.Store.Size 100, 100
    FS.Store.Size 250, 250
  ]
  filter:
    allow:
      contentTypes: ['image/*']

Mongo.Avatars.allow
  insert: -> yes
  update: -> yes
  download: -> yes
