;;; starter-kit-m2ym.el --- Tomohiro Matsuyama (aka m2ym) softwares
;;
;; Not part of the Emacs Starter Kit


;; Need to set resense-home
(setq rsense-home (concat src-dir "/rsense"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat src-dir "/auto-complete/dict"))
(ac-config-default)
(setq ac-auto-start t)                  ;automatically start
(setq ac-dwim 3)                        ;Do what i mean
(ac-flyspell-workaround)                ;to fix auto-complete when flyspell-mode on

;; ruby-mode completion with rsense
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))

;; filename completion for eshell-mode
(add-to-list 'ac-modes 'eshell-mode)
(add-hook 'eshell-mode-hook
	  (lambda ()
	    (add-to-list 'ac-sources ac-source-files-in-current-dir)))

(provide 'starter-kit-m2ym)
;;; starter-kit-m2ym.el ends here
