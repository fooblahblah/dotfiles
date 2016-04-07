(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(global-set-key (kbd "C-c /") 'comment-or-uncomment-region)

(require 'nix-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(purescript-mode-hook (quote (turn-on-purescript-indentation))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (require 'twittering-mode)
;; (setq twittering-use-master-password t)


(add-hook 'after-init-hook #'global-flycheck-mode)
(require 'company)

;; Enable company globally for all mode
(global-company-mode)

;; Reduce the time after which the company auto completion popup opens
(setq company-idle-delay 0.2)

;; Reduce the number of characters before company kicks in
(setq company-minimum-prefix-length 1)

;; Set path to racer binary
(setq racer-cmd "/home/jsimpson/bin/racer")

;; Set path to rust src directory
(setq racer-rust-src-path "/home/jsimpson/workspace/rust/src/")

;; Load rust-mode when you open `.rs` files
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(require 'compile)

(add-hook 'rust-mode-hook
	  (lambda ()
	    (set (make-local-variable 'compile-command)
		 (if (locate-dominating-file "Cargo.toml")
		     "cargo build"
		   "rustc *.rs"))))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(add-hook 'rust-mode-hook
	  (lambda ()
	    ;; Use flycheck-rust in rust-mode
	    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
	    
	    ;; Key binding to auto complete and indent
	    (local-set-key (kbd "TAB") #'company-indent-or-complete-common)))

