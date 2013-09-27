# brlyblrg
![brlyblrg logo](docs/img/brlyblrg-logo.png "brlyblrg logo")


## What is this?
This is a simple blog engine using Ruby and Dropbox. Once you have given the app permission to access your Dropbox account, it will create /Apps/Blog-Drop/. It will read markdown files in this folder and save them to the posts table of your database.


## Getting started locally
1. Fork the project
2. Put your database info in .env.example file and rename it .env
3. Create your [Dropbox app](docs/CreateDropboxApp.pdf).
3. Authenticate the app with Dropbox
4. Write some blog posts
5. foreman start (Foreman is used to simply deploying to Heroku.)


## Deploying to Heroku
1. Get it running locally
2. Set Heroku ENV variables:
  - heroku config:set APP_KEY=999999999999999
  - heroku config:set APP_SECRET=999999999999999
  - heroku config:set DATABASE_URL=[DB connection string]
3. git push heroku master
4. heroku run lib/blryblrg.rb
5. Follow the instructions.
6. Write some blog posts.
7. Profit.


## Front-matter format
```YAML
 # ---
 # title: Post Title
 # description: post Description
 # permalink: this-is-a-unique-key
 # ---
```
The only front-matter that is required is the `permalink`. It uses this as the unique key to identify posts. The other front-matter keys should match the columns in your posts table, as it will try to insert/update whatever it finds.

Putting `status: draft` in the front matter will prevent this post from being added to the DB. If it is added to an existing post, that post wil be removed from the DB, but left in the Dropbox folder.

Required fields in the `posts` table are:

- permalink
- body
- filename


## TODO

Want to contribute?

- Check options against Posts Schema before insert/update and remove any options that are not in the schema
- Setup gh-pages branch
- Copy assets to configurable location
- Improve configuration options (DB table name, etc.)
- Add tests and clean up code


## Collaborators

Special thanks to all those who have helped:

- @asimpson
- @yock
- @neilrenicker


## Release History
See [CHANGELOG](CHANGELOG).


## Legal Stuff
The MIT License (MIT)

Copyright (c) [2013] [Rob Tarr]

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.