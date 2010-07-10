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

;; latest ecb from http://www.emacsmirror.org
(require 'ecb)
(setq ecb-tip-of-the-day nil)
(ecb-activate)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(toggle-fullscreen)

(provide 'starter-kit-selman)
;;; starter-kit-selman.el ends here
