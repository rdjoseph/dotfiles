       							       ;;;;;;;;;;;;;;;;
							       ; EMACS CONFIG ; 
							       ;;;;;;;;;;;;;;;;
;;;;;;;;;;

;; If you don't use unicode in 2021, you've made a mistake 
(prefer-coding-system 'utf-8) 
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-codingn-system 'utf-8)

;;(load-theme 'dracula t)

;;;;;;;;;;;;
; PACKAGES ;
;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
; Bootstrap use-package and its accessories 
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (package-install 'diminish)
  (package-install 'bind-key))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
(setq use-package-always-ensure t)

;; use-package good-scroll ??
;; Provides bezier-curve algorithm based pixel scrolling

(use-package powerline
  :init (powerline-default-theme))

(require 'tramp)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
	 ("<C-return>" . ivy-immediate-done)) 
  :config
  (ivy-mode 1))
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; Provides a vertical line along indent lines, handy for block based langs
(use-package indent-guide
  :defer t 
  :hook ((prog-mode . indent-guide-mode)))


(use-package free-keys
  :defer t) ; Display free keybindings

;; TODO: Make some more helpful notes on this 
(use-package google-this ; C-c / RET opens a minibuffer to google something.
  :bind (("C-c / RET" . google-this))
  :init
  :diminish)

;; (use-package which-key
;;  :init (which-key-mode)
;;  :config (which-key-setup-side-window-right))
;; TODO: Hydra? Figuring this out better? 

;; 
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)) ; We want to start emacs in emacs mode, but with vi ready to go at the touch of C-z 

; make C-Z toggle evil-mode, as C-z temporarily suspends evil mode in evil mode 
; normally, C-Z/z calls 'suspend-frame, but the default secondary mapping of C-x C-z also works for that 
;; Maybe this should be 'turn-off-evil-in-buffer ? That way it can just be killed for the appropriate buffer 
(global-set-key (kbd "C-S-z") 'evil-mode) 

(add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 1)))

;; Org is killer software, and it's worth learning emacs just for it
;; However it's a bit ugly by default. We can turn on some settings to fix this 
(use-package org
  :bind (("<C-tab>" . org-metaright)
	 ("<C-iso-lefttab>" . org-metaleft))
  :config
  (setq ;; Fix startup settings
        org-startup-indented t
	org-startup-folded t
	org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  :hook (org-mode . visual-line-mode) ; Line wrapping is crucial 
  :init)

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package ox-pandoc) ;; Allows org exporter ("ox") to use pandoc as a backend.

 
(use-package company
 :ensure t
 :config
 (setq company-idle-delay 0.3)
 (global-company-mode 1))

(use-package magit)

;; We want hs-minor-mode for all programming languages.
(add-hook 'prog-mode-hook #'hs-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  LANGUAGE SPECIFIC CONFIG  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Language Server Protocol & Friends
(use-package flycheck)

(use-package lsp-mode
  :ensure t 
  :config
  (progn
    (message "DEBUG: lsp-mode config run")
  (lsp-register-client
    (make-lsp-client
    :new-connection (lsp-stdio-connection
		    (lambda () (list "/usr/local/bin/phpactor" "language-server")))
    :major-modes '(php-mode)
    :priority -1
    :initialization-options (ht)
    :server-id 'phpactor)))
  :commands lsp)

(use-package lsp-ui
 :requires lsp-mode flycheck
 :config
 (setq lsp-ui-doc-enable t
 lsp-ui-doc-use-childframe t
 lsp-ui-doc-position 'top
 lsp-ui-doc-include-signature t
 lsp-ui-sideline-enable nil
 lsp-ui-flycheck-enable t
 lsp-ui-flycheck-list-position 'right
 lsp-ui-flycheck-live-reporting t
 lsp-ui-peek-enable t
 lsp-ui-peek-list-width 60
 lsp-ui-peek-peek-height 25
 lsp-ui-sideline-enable nil)
 (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company-lsp
  :commands company-lsp)

;;; PHP & Web Dev 
(use-package php-mode
  :defer t
  :ensure t)

(use-package web-mode
  :defer t)

;;; LISP & Friends
;; My C-M-{key} doesn't work for obscure hardware reasons sometimes, so I've rebound some keys to more essential movements 
(use-package paredit
  :defer t
  :bind (("M-f" . paredit-forward)
	 ("M-b" . paredit-backward)
	 ("M-d" . down-list)
	 ("M-u" . paredit-backward-up)))

;; Guile / Scheme
(use-package geiser)

;; Common Lisp (Steel Bank Common Lisp)
(use-package slime
  :config
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "/usr/bin/sbcl"))

;; Clojure
(use-package cider
  :ensure t
  :hook (cider . paredit-mode))


;;;;;;;;;;;;;
;  STARTUP  ;
;;;;;;;;;;;;;

; Emacs should always start fullscreen but only the default frame. If I create some other instance, I want that to behave normally 
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 0)         ; Maximize space, tiny screen
(menu-bar-mode -1)          ; Disable the menu bar



;;;;;;;;
; MISC ; 
;;;;;;;;

;; Set emacs title bar to display the name of the active buffer 
(setq frame-title-format
      '("" invocation-name ": " (:eval (replace-regexp-in-string
					"^ +" "" (buffer-name)))))

(show-paren-mode 1) ; When over a paren, highlight its match 

; Make the clipboard behave itself. Relevent keybindings elsewhere
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

; Keep Emacs from beeping at me
(setq ring-bell-function 'ignore)

(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
               term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

; Nav mark ring (C-u C-<SPC>), after first invocation C-<SPC> keeps popping the ring 
(setq set-mark-command-repeat-pop t) 

;;; TODO:
;; Code folding!! Desperately need to get this sorted
;; pixel-scroll-mode? Provides very smooth scrolling but it's disconcerting
;; Dired one buffer behavior?? Dired spawns a ton of buffers, it's not fun

;;;;;;;;;;;;;;;; 
; MY FUNCTIONS ; 
;;;;;;;;;;;;;;;; 

(defun RDJ/set-transparency ()
  "Prompts user for new alpha value for current frame, and sets it" 
  (interactive)
  (setq a (string-to-number (read-string "Alpha value:")))
  (set-frame-parameter (selected-frame) 'alpha a)
  (message "Alpha set to %d" a))

(defun RDJ/smart-kill-buffer-and-window ()
  "If there is more than one window, runs kill-buffer-and-window. Otherwise, runs plain kill-buffer" 
  (interactive)
  (if (> (length (window-list)) 1)
      (kill-buffer-and-window)
      (kill-buffer)))
(global-set-key (kbd "C-x C-S-k") 'RDJ/smart-kill-buffer-and-window) ;; 


(defun RDJ/whole-buffer-search-and-replace ()
  "Performs query-replace on entire buffer, and returns user to starting point when done" 
  (interactive)
  (setq str (read-string "Whole buffer query replace: "))
  (setq nstr (read-string "Whole buffer query replace with: "))
  (save-excursion
    (beginning-of-buffer)
    (query-replace str nstr)))

;; improved, vi-like newline for prog modes 
(defun RDJ/insert-line-above-without-breaking ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (open-line 1)))
(defun RDJ/insert-line-below-without-breaking ()
  (interactive)
  (save-excursion
    (end-of-line)
    (newline)))

;; Improved move-beginning-of-line ("C-a"), which allows jumping between first non-whitespace char and actual beginning
;; taken from https://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
(defun EMACSREDUX/smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.
Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.
If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))
  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; Hideshow improvement
(defun RDJ/hs/toggle-fold ()
  (interactive)
  (save-excursion
    (end-of-line)
    (hs-toggle-hiding)))


;;;;;;;;;;;;;;;
; KEYBINDINGS ; 
;;;;;;;;;;;;;;;

; Cycling between buffers. I considered this a lot, but :; should be right under my pinky, I hit it a lot 
(global-set-key (kbd "s-:") 'bs-cycle-previous)
(global-set-key (kbd "s-;") 'bs-cycle-next)
; Moving between windows. Because vi-style arrows
(global-set-key (kbd "s-h") 'windmove-left)
(global-set-key (kbd "s-l") 'windmove-right)
(global-set-key (kbd "s-j") 'windmove-down)
(global-set-key (kbd "s-k") 'windmove-up)

; Misc improvements 
(global-set-key (kbd "C-h i") 'info-display-manual)  ; Fix Info's main access to be more searchable
(global-set-key (kbd "C-S-k") 'kill-whole-line)      ; Uppercase letters should do what their lowercase counterparts do but More
(global-set-key (kbd "C-S-y") 'clipboard-yank)       ; We need to be able to paste random code from the internet, otherwise we're not real programmers

;; Fix C-o/O 
(define-key prog-mode-map (kbd "C-S-o") 'RDJ/insert-line-above-without-breaking)
(define-key prog-mode-map (kbd "C-o") 'RDJ/insert-line-below-without-breaking)

;; Fix move-beginning-of-line to be content aware in a toggle-able way 
(global-set-key [remap move-beginning-of-line]
                'EMACSREDUX/smarter-move-beginning-of-line)

(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-z C-a") 'RDJ/hs/toggle-fold)

(global-set-key (kbd "C-<") 'hs-hide-block)
(global-set-key (kbd "C->") 'hs-show-block)
(global-set-key (kbd "<f5>") 'revert-buffer)

;;;;;;;;;;;;;;;
;    THEME    ; 
;;;;;;;;;;;;;;;


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(wheatgrass))
 '(custom-safe-themes
   '("191bc4e53173f13e9b827272fa39be59b7295a0593b9f070deb6cb7c3745fd1d" default))
 '(lsp-php-language-server-command
   '("php" "~/.local/opt/php-language-server/vendor/bin/php-language-server.php"))
 '(org-agenda-files '("~/Desktop/week.org"))
 '(package-selected-packages
   '(powerline dracula-theme indent-guide ox-pandoc command-log-mode cider org-bullets magit tramp vterm paredit geiser slime eglot rust-mode web-mode lsp-clients dap-mode lsp-treemacs lsp-ivy lsp-php php-mode company-lsp lsp-ui flycheck company lsp-mode helpful which-key orgalist counsel ivy-rich ivy diminish bind-key use-package google-this google-this-mode free-keys evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
