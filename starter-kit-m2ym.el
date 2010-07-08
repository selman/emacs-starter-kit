;;; starter-kit-m2ym.el --- Tomohiro Matsuyama (aka m2ym) softwares
;;
;; Not part of the Emacs Starter Kit


;; Need to set resense-home

(setq rsense-home (concat dotfiles-dir "src/rsense"))
(add-to-list 'load-path (concat rsense-home "/etc"))

;; Adding ac-dictionary-directories giving error

;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/dict")
(require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-start t)                  ;automatically start
(setq ac-dwim 3)                        ;Do what i mean
(ac-flyspell-workaround)                ;to fix auto-complete when flyspell-mode on

(provide 'starter-kit-m2ym)
;;; starter-kit-m2ym.el ends here
