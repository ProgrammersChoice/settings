(setq inhibit-startup-message t)

;(unless dw/is-termux
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)       ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; Set font
(set-face-attribute 'default nil :family "D2Coding" :height 130)
;(set-face-font 'default (font-spec :family "D2Coding 13")
;(set-fontset-font t 'hangul (font-spec :name "D2Coding"))
(setq default-input-method "korean-hangul")

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Fix an issue accessing the ELPA archive in Termux
;(when dw/is-termux
;  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))
(require 'use-package)

;; Uncomment this to get a reading on packages that get loaded at startup
;;(setq use-package-verbose t)

;; On non-Guix systems, "ensure" packages by default
(setq use-package-always-ensure t)


(use-package command-log-mode)

(use-package vertico
  :ensure t
  :bind (:map vertico-map
	      ("C-j" . vertico-next)
	      ("C-k" . vertico-previous)
	      ("C-f" . vertico-exit)
	      :map minibuffer-local-map
	      ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ag rg ripgrep hydra evil-collection undo-tree evil general all-the-icons-dired doom-modeline marginalia vertico command-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(column-number-mode) 
(global-display-line-numbers-mode t) ;;t 는 시작시 묻지말고 셋하라는 의미
;; Enable line numbers for some modes
(dolist (mode '(term-mode-hook
		eshell-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))


;; Override some modes which derive from the above
;;(dolist (mode '(org-mode-hook))
;;  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(require 'doom-modeline)
(doom-modeline-mode 1)

(use-package all-the-icons
  :if (display-graphic-p)
  :commands all-the-icons-install-fonts
  :init
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts t)))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))

(use-package doom-themes)
(load-theme 'doom-gruvbox 1)

(use-package  rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package  which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))
;;

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;(global-set-key (kbd "C-M-j") 'switch-to-buffer)

;;내맘데로 키 정의하기
(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer my/leader-keys
    :keymaps '(normal insert visual emacs)
    ;:prefix "C-M"
    :global-prefix "C-SPC")
  (my/leader-keys
   "ts" '(load-theme :which-key "choose theme")))

(use-package undo-tree
  :init
  (setq undo-tree-auto-save-history nil)
  (global-undo-tree-mode 1))

(use-package evil
  ;; Pre-load configuration
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-tree)

  :config
  ;; Activate the Evil
  (evil-mode 1)

  ;; Set Emacs state modes
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;.projectile파일을 폴더에 넣으면 프로젝트로 인식함 .git이 있어도 됨
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map) ;;모든 프로젝타일 키를 C-c p 로 트리거하겠다
  :init
  (when (file-directory-p "~/workspace")
    (setq projectile-project-search-path '("~/workspace")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package rg)
(use-package ag)

;;(use-package hydra)

;;highlight
;;M-s h . 현재 단어 하이라이트
;;M-s h r 정규식 하이라이트
;;M-s h u 삭제

;;use-package는
;;ensure t은 package가 로컬에 없을때 다운로드 하게함
;;init은 패키지 로드 전 실행랄 코드
;;command 는 autoload명령으로 init과 config사이 동작
;;config는 패키지 로드 후 실행할 내용
;;bind는 M-x describe-personal-keybinding 에 키 바인딩 적재 시킴
;;이것과 동일하게 일을 시키는건 아래와 같음
;; init
;; (bind-key "C-." 'ace-jumbp-mode))
;;bind-keymap은 비슷한데 그 패키지에 정의된 keymap만 사용가능
