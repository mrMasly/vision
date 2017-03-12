import _ from 'lodash'

getStore = (size, width) ->
  if Meteor.isClient
    new FS.Store.FileSystem size
  else
    new FS.Store.FileSystem size,
      path: Meteor.root+"/../files/fs/avatars/#{size}/"
      transformWrite: (file, readStream, writeStream) ->
        gm readStream, file.name()
          .resize null, width
          .stream()
          .pipe writeStream

Mongo.Avatars = new FS.Collection 'avatars',
  stores: [
    getStore 'xs', 50
    getStore 'sm', 100
    getStore 'md', 250
  ]
  filter:
    allow:
      contentTypes: ['image/*']

Mongo.Avatars.allow
  insert: -> yes
  update: -> yes
  download: -> yes
