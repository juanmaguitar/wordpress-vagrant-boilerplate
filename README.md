# Wordpress w/ Vagrant Boilerplate

This repository contains a boilerplate for wordpress projects that include:

- Wordpress as a submodule 
- Vagrant VM w/ Linux pointing to WP
- Child theme template w/ grunt tasks


## Installation

Clone the repository:

    git clone --recursive https://github.com/juanmaguitar/wordpress-vagrant-boilerplate.git

And remove this origin repository from your working copy:

    cd wordpress-vagrant-boilerplate
    git remote rm origin
    
Add your new origin repository to your working copy:

    git remote add origin <url_here>


## Upgrading Wordpress

After installing this boilerplate, keeping Wordpress up-to-date via git is pretty easy.

Go to the submodule directory:

    cd www/wordpress

Fetch the tags from git:

    git tag

Checkout the version you want to upgrade to (e.g. git checkout 4.2):

    git checkout <tag>

Commit your Wordpress upgrade:

    cd ..
    git commit -m "Updating wordpress to <tag-name>"

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

## Do changes on child theme and live reload the browser

You'll need this plugin installed on Chrome -> https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei

From `\www\wp-content\themes\_twentyten-child\` folder we do

    npm install

and then we can do

    grunt serve

This command will allow us to `enable livereload` on the plugin, so every time our files change, the browser will be reloaded

