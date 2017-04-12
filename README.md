# MODX Revolution Development Docker

Docker setup that makes it easier to clone MODX Revolution from GitHub. 

Cloning MODX Revolution from GitHub and doing all the necessary setup can be a tedious process. Not to mention configuring PHP, Apache/nginx and MySQL/MSSQL correctly. This Docker setup does all of this work for you with a few simple commands. It creates a Apache (2.4.10) web server running PHP (7.1.2), as well as a MySQL database (5.7.17). The web server mounts your MODX Revolution files and exposes them to you via localhost. 

## Requirements

- [Docker](https://www.docker.com/community-edition)
- [Docker compose](https://docs.docker.com/compose/install/)

*Note that Docker compose is included in the Docker Toolbox, so if you install that you do not need to install the standalone version.*

We supply a Makefile to make it easier to use this setup. UNIX based systems should have Make installed by default. Windows systems need to install this manually. It is also possible to use this setup without Make, but you will have to type out some of the tasks manualy instead of relying on the provided shortcuts.

## Setup

First, make sure you have forked the MODX Revolution repository as described in the [rtfm pages](https://docs.modx.com/revolution/2.x/getting-started/installation/git-installation#GitInstallation-GitLocation). You only need to follow the steps under "Installation Process" before the section named "Run the Build".
 
Now that you have your up-to-date fork, clone it in **THIS** directory into `revolution`. Example command:

```
git clone git@github.com:[your-username]/revolution.git
 ```

With the files in place, we can now spin up the Docker containers. A Makefile is provided to automate some of the process.

To build and start everything:

```
make
```

To stop the machine type:

```
make stop
```

We also provide a command for [building the transport file](https://docs.modx.com/revolution/2.x/getting-started/installation/git-installation#GitInstallation-RuntheBuild). This is necessary to do before you can run the MODX setup if you do not already have the `core.transport.zip` file in your package directory. This command also copies `ht.access` to `.htaccess`. Note that this command takes some time to finish. Run it with:

```
make prepare
```

*The other commands are listed in the [Makefile](https://github.com/OptimusCrime/modx-development-docker/blob/master/Makefile), and should be relatively self explanatory.*

## Access

The website is now accessible at [`http://localhost:8000`](http://localhost:8000) on UNIX based systems. On Windows machines you need to find the [Docker machine IP](https://docs.docker.com/machine/reference/ip/), but the port is the same.

You can also access the database on port `3306`. On UNIX based systems this is through localhost, but Windows machines also require the Docker machine IP for this. Username, password and database name are all `revolution`.

## Contribute

I am pretty new to Docker myself, so there might be better ways of doing certain things. Feel free to open PRs and issues.
