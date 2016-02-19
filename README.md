# ansible-make
simple demo using make and ansible

if you have a number of ansible playbooks that you want to run frequently and ensure consistency, 
you might want to consider make.

make allows you to get up some basic rules to run your playbooks. tchese can then be used 
consistently by a development team or by your ci/cd tools.

## installing make
make comes pre-installed on most linux distros. If it isn't you can easily add it by 
```sudo apt-get install build-essential``` on a debian/ubuntu host
