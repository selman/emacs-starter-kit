;;; starter-kit-selman.el --- Selman Ulug additions to emacs-starter-kit
;;
;; Not part of the Emacs Starter Kit

;; latest color-theme from http://www.emacsmirror.org
(require 'color-theme)
(color-theme-initialize)

;; latest yasnippets from http://www.emacsmirror.org
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat src-dir "/yasnippet/snippets"))

;; ruby-debug copied from
;; http://github.com/mark-moseley/ruby-debug/tree/master/emacs/
(require 'rdebug)

(toggle-fullscreen)

(provide 'starter-kit-selman)
;;; starter-kit-selman.el ends here
