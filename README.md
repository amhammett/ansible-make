# ansible-make
simple demo using make and ansible

if you have a number of ansible playbooks that you want to run frequently and ensure consistency, 
you might want to consider make.

make allows you to get up some basic rules to run your playbooks. tchese can then be used 
consistently by a development team or by your ci/cd tools.

## installing make
make comes pre-installed on most linux distros. If it isn't you can easily add it by 
```sudo apt-get install build-essential``` on a debian/ubuntu host

## getting started

start by creating a Makefile

    # Makefile

    hello-world:
    # you have to start somewhere
    	@echo hello world

running `make hello-world` will echo out "hello world"...

with that out of the way, how about some real-world examples?

## simple ansible

suppose you want to run a run a playbook to push out the latest configuration for a webserver.

    # Makefile

    deploy-web
    # push out web server configuration
    	ansible-playbook web.yml -i localhost,
