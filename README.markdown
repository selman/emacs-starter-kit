# Changes from Emacs Starter Kit

This modifications firstly targeting Ruby users and some modifications like
"auto-complete" usefull for all users. You can add not included
usefull packages like "rinari" for Ruby on Rails through ELPA.

* added "Rakefile" changed install method (look Installation)
* latest compiled rsense added
* auto-complete added as submodule
* ecb added as submodule
* yasnippet added as submodule (no need to install from ELPA)
* color-theme and themes removed from "elisp-to-submit" and added as submodule
* css-mode and yaml-mode removed from automatic install
* menu-bar-mode enabled

## Requirements

* Emacs >= 23.2
  for ecb if you have lower version you can install "cedet" or disable
  "ecb" to use
* Java runtime Sun or Openjdk
  for rsense if you don't want to install disable rsense
* git gem (sudo gem install git)
  for installation and updating if you don't want install static
  package http://github.com/selman/emacs-starter-kit/downloads

# Emacs Starter Kit

The Starter Kit should provide a saner set of defaults than you get
normally with Emacs. It was originally intended for beginners, but it
should provide a reasonable working environment for anyone using Emacs
for dynamic languages. It also bundles a number of useful libraries
that are not distributed with Emacs for various reasons.

The latest version is at http://github.com/technomancy/emacs-starter-kit/

## Learning

This won't teach you Emacs, but it'll make it easier to get
comfortable. To access the tutorial, press control-h followed by t.

You may also find the [PeepCode Meet Emacs
screencast](http://peepcode.com/products/meet-emacs) helpful. The
[Emacs Wiki](http://emacswiki.org) is also very handy.

## Installation

Choose one of the installation methods:

1. Static package
   * Download [Download Page](http://github.com/selman/emacs-starter-kit/downloads)
   * backup your "~/.emacs.d" folder
   * cd ~/ && tar zxvf esk-selman-x-x-x.tar.gz

2. Cloning
   * git clone git://github.com/selman/emacs-starter-kit.git
   * cd emacs-starter-kit
   * rake install

3. Forking
   * git clone git@github.com:YOURUSER/emacs-starter-kit.git
   * cd emacs-start-kit
   * rake install

if you installed as 2. or 3. you can update with "rake update". if you
installed as 3. you can push your changes with "rake merge" then "rake
push" (if you want to save your branch to github use "git push all"
you must add your personel files to ".gitignore")

If you find yourself missing some autoloads after an update (which
should manifest itself as "void function: foobar" errors) try M-x
regen-autoloads. After some updates an M-x recompile-init will be
necessary; this should be noted in the commit messages.

Note that having a ~/.emacs file might override the starter kit
loading, so if you've having trouble loading it, make sure that file
is not present.

## Structure

The init.el file is where everything begins. It's the first file to
get loaded. The starter-kit-* files provide what I consider to be
better defaults, both for different programming languages and for
built-in Emacs features like bindings or registers.

Directories under the "src" directory will be added the load-path
automatic. if you added any folder or submodule here you don't need
to define load-path.

Files that are pending submission to ELPA are bundled with the starter
kit under the directory elpa-to-submit/. The understanding is that
these are bundled just because nobody's gotten around to turning them
into packages, and the bundling of them is temporary. For these
libraries, autoloads will be generated and kept in the loaddefs.el
file. This allows them to be loaded on demand rather than at startup.

There are also a few files that are meant for code that doesn't belong
in the Starter Kit. First, the user-specific-config file is the file
named after your user with the extension ".el". In addition, if a
directory named after your user exists, it will be added to the
load-path, and any elisp files in it will be loaded. Finally, the
Starter Kit will look for a file named after the current hostname
ending in ".el" which will allow host-specific configuration. This is
where you should put code that you don't think would be useful to
everyone. That will allow you to merge with newer versions of the
starter-kit without conflicts.

## Emacs Lisp Package Archive

Libraries from [ELPA](http://tromey.com/elpa) are preferred when
available since dependencies are handled automatically, and the burden
to update them is removed from the user. In the long term, ideally
everything would be installed via ELPA, and only package.el would need
to be distributed with the starter kit. (Or better yet, package.el
would come with Emacs...) See starter-kit-elpa.el for a list of
libraries that are pending submission to ELPA. Packages get installed
in the elpa/ directory.

There's no vendor/ directory in the starter kit because if an external
library is useful enough to be bundled with the starter kit, it should
be useful enough to submit to ELPA so that everyone can use it, not
just users of the starter kit.

Sometimes packages are removed from the Starter Kit as they get added
to ELPA itself. This has occasionally caused problems with certain
packages. If you run into problems with such a package, try removing
everything from inside the elpa/ directory and invoking M-x
starter-kit-elpa-install in a fresh instance.

## Variants of Emacs

if your Emacs version lower than 23.2 you must install "cedet" or
disable "ecb".

The Starter Kit is designed to work with GNU Emacs version 22 or
greater. Using it with forks or other variants is not supported. It
probably won't work with XEmacs, though some have reported getting it
to work with Aquamacs. However, since Aquamacs is not portable,
it's difficult to test in it, and breakage is common.

## Contributing

If you know your way around Emacs, please try out the starter kit as a
replacement for your regular dotfiles for a while. If there's anything
you just can't live without, add it or let me know so I can add
it. Take a look at what happens in init.el to get started.

Also: see the file TODO. Helping submit new libraries to ELPA is the
easiest way to help out. There are two ways you can do this: either
take new libraries and make them ready for ELPA, dropping them in the
elpa-to-submit directory or take files that are already in
elpa-to-submit, ensuring all their dependencies are correctly loaded
into ELPA, and sending them to the ELPA maintainer. There are details
at http://tromey.com/elpa/upload.html for how ELPA submission
works. Grep the project for TODO for other things.

Files are licensed under the same license as Emacs unless otherwise
specified. See the file COPYING for details.

The latest version is at http://github.com/technomancy/emacs-starter-kit/

On Unix, /home/$USER/.emacs.d, on windows Documents and Settings/%your
user name%/Application Data

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

[Twitter](http://twitter.com/selmanulug)
