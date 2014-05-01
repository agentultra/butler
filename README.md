Butler
======

A Common Lisp kernel for iPython frontends.

See http://ipython.org/notebook.html for why this is cool.

# Contributing #

See
[the message protocol](http://ipython.org/ipython-doc/dev/development/messaging.html)
for implementation details.

Implementing a basic functional kernel only requires implementing:

* `kernel_info_request`
* `kernel_info_reply`
* `execute_request`
* `execute_reply`

At minimum... but it still won't display anything useful to the
front-end. For that we'll need the IOPub channels and state messages.

Pull requests welcome.

# Building #

Currently developing on Clozure with the intention of supporting more
implementations in the future. These notes are for building on
Clozure.

First load the system with asdf or add to your quicklisp.

    (ccl:save-application "butler" :toplevel-function #'butler:main :prepend-kernel t)`

Then create a Common Lisp iPython profile:

    $ ipython profile create common-lisp`

And at the top of `~/.ipython/profile_common-lisp/ipython_config.py`:

    c = get_config()
    c.KernelManager.kernel_cmd = ["/path/to/butler",
                                  "{connection_file}"]

Then you can start it up with:

    $ ipython console --profile common-lisp

Just don't expect anything to happen yet until more messages and
sockets are set up.
