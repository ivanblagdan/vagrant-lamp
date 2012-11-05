What
====
Vagrant/Chef files for a LAMP server with PHP build.

How
===
1. Install [vagrant](http://vagrantup.com/)

        gem install vagrant
2. Download and Install [VirtualBox](http://www.virtualbox.org/)
3. Clone this repo
4. Go to the repo dir and launch the box

        cd [repo]
        vagrant up

5. Add this line to your `/etc/hosts` (or windows equivalent)
    127.0.0.1 php-test.local

That's it, the file in [repo]/public/ are served here : [http://php-test.local:8080/](http://php-test.local:8080/)

[http://php-test.local:8080/?XDEBUG_PROFILE](http://php-test.local:8080/?XDEBUG_PROFILE)
[http://localhost:8080/webgrind/](http://localhost:8080/webgrind/)




