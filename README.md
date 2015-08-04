## Cloning the repository

    $ git clone --recursive https://juanmaguitar@bitbucket.org/juanmaguitar/surfmocion.git

The `--recursive` parameter is important so the submodules can be created and updated properly

## Installing dependencies

We need to have installed in our machine the following tools
- Node.js
- NPM
- Vagrant (w/ Virtual Box)
- Grunt CLI (globally)

With these tools instaled we can do from the root folder:

    npm install

to install all dependencies

## Accesing site LOCALLY

Get up vagrant from `vagrant` folder

    vagrant up

after this, at http://192.168.56.130/ we could see our site

#### Do changes and live reload the browser

You'll need this plugin installed on Chrome -> https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei

From the root folder we can do

    grunt serve

This command will allow us to `enable livereload` on the plugin, so every time our files change, the browser will be reloaded

