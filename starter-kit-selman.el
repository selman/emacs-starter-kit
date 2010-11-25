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
(setq yas/prompt-functions '(yas/ido-prompt))
(setq yas/also-auto-indent-first-line t)

;; ruby-debug copied from
;; http://github.com/mark-moseley/ruby-debug/tree/master/emacs/
(require 'rdebug)

;; Smex is a M-x enhancement
(require 'smex)
(smex-initialize)

(provide 'starter-kit-selman)
;;; starter-kit-selman.el ends here
