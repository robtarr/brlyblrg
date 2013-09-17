# brlyblrg
![brlyblrg logo](docs/img/brlyblrg-logo.png "brlyblrg logo")


## What is this?

This is a simple blog engine using Ruby and Dropbox. Once you have given the app permission to access your Dropbox account, it will create /Apps/Blog-Drop/. It will read markdown files in this folder and save them to the posts table of your database.

## Getting started
1. Fork the project
2. Put your database info in .env.example file and rename it .env
3. Create your [Dropbox app](docs/CreateDropboxApp.pdf).
3. Authenticate the app with Dropbox
4. Write some blog posts
5. foreman start (Foreman is used to simply deploying to Heroku.)
6. Profit

## Front-matter format

```YAML
 # ---
 # title: Post Title
 # description: post Description
 # permalink: this-is-a-unique-key
 # hashtag: usedfortwittercomments
 # ---
```

## To Do
1. Create a web interface for authenticating production app with Dropbox


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