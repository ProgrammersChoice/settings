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

(custom-set-variables
 '(package-selected-packages
   '(evil-magit magit ag rg ripgrep hydra evil-collection undo-tree evil general all-the-icons-dired doom-modeline marginalia vertico command-log-mode use-package)))
(custom-set-faces
 )

(set-face-attribute 'default nil :family "D2Coding" :height 130)
(setq default-input-method "korean-hangul")

(column-number-mode) 
(global-display-line-numbers-mode t) ;t 는 시작시 묻지말고 셋하라는 의미
;; Enable line numbers for some modes
(dolist (mode '(term-mode-hook
		eshell-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

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

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

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

;https://youtu.be/INTu30BHZGk
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map) ;;모든 프로젝타일 키를 C-c p 로 트리거하겠다
  :init
  (when (file-directory-p "~/workspace")
    (setq projectile-project-search-path '("~/workspace")))
  (setq projectile-switch-project-action #'projectile-dired))

;C-c p f이후 M-o하면 메뉴가 많아지는데 스크롤 방법을 모름.
;counsel-projectil-rg = c-p-s-r
(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package rg)
(use-package ag)

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;(require 'evil-magit)
;(use-package evil-magit
;  :after magit)

;(use-package forge)

(defun efs/org-mode-setup()
  (org-indent-mode)
  ;(variable-pitch-mode 1)
  ;(auto-fill-mode 0)
  (visual-line-mode 1))
  ;(setq evil-auto-indent nil))

(use-package org
    :hook (org-mode . efs/org-mode-setup) ;훅을 쓰는 이유는 org buffer시작할때마다 위에설정 호출해서 그버퍼는 변수상태로 셋업하기 위함.
    :config
    (setq org-ellipsis " ▾" ; S-tab하면 ... 나오는걸 이걸로 바꾸기 위함
          org-hide-emphasis-markers t)) ;bold link등 */같은거 안보이게
    (setq org-agenda-start-with-log-mode t)
    (setq org-log-done 'time)
    (setq org-log-into-drawer t)
    (setq org-agenda-files ; agenda에서 관리할 파일 리스트로 ""다음줄에 ""또넣어도됨
          '("~/workspace/org/tasks.org"
            "~/workspace/org/test.org")) ; '요거 하나는 뒤에가 리스트라는 의미로 펑션콜이 아님을 의미

  ;todo의 종류들을 추가하는 것으로 |기준으로 active냐 종료상태를 좌우로 나뉨
  (setq org-todo-keywords
        '((sequenct "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVITE(a)" "REVIEW(v)" "WAIT(w@/!)" "|" "COMPLETED(c)" "CANC(k@)")))
  (setq org-refile-targets
        '((nil :maxlevel . 1)
         (org-agenda-files :maxlevel . 1)))

;(advice-add 'org-refile :after 'org-save-all-org-buffers)
;이렇게 하면 org-refile실행시 바로 org-save-all-org-buffers가 실행이됨

;head마다 다른 사이즈
(require 'org-faces)
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.0)
                (org-level-6 . 1.0)
                (org-level-7 . 1.0)
                (org-level-8 . 1.0)))
  (set-face-attribute (car face) nil :font "D2Coding" :weight 'medium :height (cdr face)))
;head마다 끝에만 보이게 하되 글자를 다음처럼 바꾸라
(use-package  org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

; list hyphen 을 dot으로 수정
; 정규식으로 이걸 만듬
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;;visual fill mode는 org mode가 왼쪽에 치우친걸 상황을 바꿈
;set margins mode
;(defun efs/org-mode-visual-fill ()
;  (setq visual-fill-column-width 110
;        visual-fill-column-center-text t)
;  (visual-fill-column-mode 1))
;(use-package visual-fill-column
;  :hook (org-mode . efs/org-mode-visual-fill))

;org-capture
;org-capture-templates
;(setq org-capture-templates
;  `(("t" "Tasks / Projects")
;    ("tt" "Task" entry (file+olp ,(dw/org-path "Projects.org") "Projects" "Inbox")
;         "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
;    ("ts" "Clocked Entry Subtask" entry (clock)
;         "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
;    ("tp" "New Project" entry (file+olp ,(dw/org-path "Projects.org") "Projects" "Inbox")
;         "* PLAN %?\n  %U\n  %a\n  %i" :empty-lines 1)
;
;    ("j" "Journal Entries")
;    ("jj" "Journal" entry
;         (file+olp+datetree ,(dw/get-todays-journal-file-name))
;         ;"\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
;         ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
;         :clock-in :clock-resume
;         :empty-lines 1)
;    ("jm" "Meeting" entry
;         (file+olp+datetree ,(dw/get-todays-journal-file-name))
;         "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
;         :clock-in :clock-resume
;         :empty-lines 1)
;    ("jt" "Thinking" entry
;         (file+olp+datetree ,(dw/get-todays-journal-file-name))
;         "\n* %<%I:%M %p> - %^{Topic} :thoughts:\n\n%?\n\n"
;         :clock-in :clock-resume
;         :empty-lines 1)
;    ("jc" "Clocked Entry Notes" entry
;         (file+olp+datetree ,(dw/get-todays-journal-file-name))
;         "* %<%I:%M %p> - %K :notes:\n\n%?"
;         :empty-lines 1)
;    ("jg" "Clocked General Task" entry
;         (file+olp+datetree ,(dw/get-todays-journal-file-name))
;         "* %<%I:%M %p> - %^{Task description} %^g\n\n%?"
;         :clock-in :clock-resume
;         :empty-lines 1)
;
;    ("w" "Workflows")
;    ("we" "Checking Email" entry (file+olp+datetree ,(dw/get-todays-journal-file-name))
;         "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)
;
;    ("m" "Metrics Capture")
;    ("mw" "Weight" table-line (file+headline "~/Notes/Metrics.org" "Weight")
;     "| %U | %^{Weight} | %^{Notes} |" :kill-buffer)
;    ("mp" "Blood Pressure" table-line (file+headline "~/Notes/Metrics.org" "Blood Pressure")
;     "| %U | %^{Systolic} | %^{Diastolic} | %^{Notes}" :kill-buffer)))

; org-babel에서 사용할수 있는 언어 등록
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)))

(setq org-confirm-babel-evaluate nil) ;;실행할지 묻는거 끄기
(setq org-babel-python-command "python3") ;;python3써라

;;<py 입력후 탭 하면 블록이 생김
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

;이 파일을 저장하면 자동으로 tangle해서 저장하도록 하고싶다면
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
		      (expand-file-name "/Users/eddie/.emacs.d/init.org"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))
 (add-hook 'org-mode-hook (lambda ()(add-hook 'after-save-hook #'efs/org-babel-tangle-config)))
