(setq inhibit-startup-message t)

;(unless dw/is-termux
(scroll-bar-mode -1)        ; disable visible scrollbar
(tool-bar-mode -1)          ; disable the toolbar
(tooltip-mode -1)           ; disable tooltips
(set-fringe-mode 10)       ; give some breathing room

(menu-bar-mode -1)            ; disable the menu bar

;; set up the visible bell
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; adjust font size 
(defvar efs/default-font-size 180)

;; set frame transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
;; fix an issue accessing the elpa archive in termux
;(when dw/is-termux
;  (setq gnutls-algorithm-priority "normal:-vers-tls1.3"))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; initialize use-package on non-linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))
(require 'use-package)

;; uncomment this to get a reading on packages that get loaded at startup
;;(setq use-package-verbose t)

;; on non-guix systems, "ensure" packages by default
(setq use-package-always-ensure t)

;.emacs.d에다가 tmp만들어서 거기 다 백업
;(setq backup-directory-alist '(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))
;모든 백업을 끌때
(setq make-backup-files nil)

;https://github.com/emacscollective/no-littering
;패키지들이 잡다하게 만드는 파일들의 위치를 정리해줌
(use-package no-littering)

; 폴더 없으면 생기게 하고
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

;(setq create-lockfiles nil)

(custom-set-variables
 '(package-selected-packages
   '(evil-magit magit ag rg ripgrep hydra evil-collection undo-tree evil general all-the-icons-dired doom-modeline marginalia vertico command-log-mode use-package)))
(custom-set-faces
 )

(defun efs/set-font-faces ()
  (message "Setting faces!")
  (set-face-attribute 'default nil :family "d2coding" :height 135)
  (setq default-input-method "korean-hangul")
  (set-fontset-font t 'hangul (font-spec :name "d2coding"))
  (global-set-key (kbd "S-SPC") 'toggle-input-method))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (setq doom-modeline-icon t)
                (with-selected-frame frame
                  (efs/set-font-faces))))
    (efs/set-font-faces))

(column-number-mode) 
(global-display-line-numbers-mode t) ;t 는 시작시 묻지말고 셋하라는 의미
(setq display-line-numbers-type 'relative)
;; enable line numbers for some modes
(dolist (mode '(term-mode-hook
                eshell-mode-hook
                vterm-mode-hook
                treemacs-mode-hook
                shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

(use-package doom-modeline)
(doom-modeline-mode 1)

(use-package all-the-icons
  :if (display-graphic-p)
  :commands all-the-icons-install-fonts
  :init
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts t)))


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
  (setq which-key-idle-delay 0.1))

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
    :global-prefix "C-SPC"))
  ;(my/leader-keys
  ; "ts" '(load-theme :which-key "choose theme")))

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

(use-package evil-visualstar
  :ensure t
  :config
  (global-evil-visualstar-mode t))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;evil에서 심볼단위 검색 가능하도록 언더바 있으면 선택 안되던 문제 해결
(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol)
  ;; make evil-search-word look for symbol rather than word boundaries
  (setq-default evil-symbol-word-search t))

;선택 영역 단어 변경 vim스타일
(defun evilcvn-change-symbol-in-defun ()
  "use string replacing UI in evil-mode to replace the symbol under cursor"
  (interactive)
  (let ((old (thing-at-point 'symbol)))
    (evil-ex (concat "%s/" (if (= 0 (length old)) "" "") old (if (= 0 (length old)) "" "/"))))
  )
(global-set-key (kbd "M-s M-s") 'evilcvn-change-symbol-in-defun)

;;mac built in ls does not support group-directories-first
;;so brew install coreutils first
(if (eq system-type 'darwin)
    (setq insert-directory-program "gls" dired-use-ls-dired t))
(use-package dired-single)
(use-package dired
  :ensure nil ;use-package가 install 안하게 함.
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-al --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))
(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))
;png파일은 feh라는 툴로 열고...
(use-package dired-open
  :config
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))
;hide dot files
(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))
(defun mu-open-in-external-app ()
  "Open the file where point is or the marked files in Dired in external
  app. The app is chosen from your OS's preference."
  (interactive)
  (let* ((file-list
	  (dired-get-marked-files)))
   (mapc
    (lambda (file-path)
     (let ((process-connection-type nil))
      (start-process "" nil "xdg-open" file-path))) file-list)))
(define-key dired-mode-map (kbd "C-<return>") #'mu-open-in-external-app)

;;easymotion C-'를 트리거로 설정
(use-package avy)
(evil-define-key '(normal visual) 'global
 "," #'avy-goto-char-2)

;;evil-multiedit 힐스너 버전
;(use-package evil-multiedit)
;(evil-multiedit-default-keybinds)
;(use-package evil-mc)
;(global-evil-mc-mode 1)
;; evil-mc
;(evil-define-key '(normal visual) 'global
;  "gzm" #'evil-mc-make-all-cursors
;  "gzu" #'evil-mc-undo-all-cursors
;  "gzz" #'+evil/mc-toggle-cursors
;  "gzc" #'+evil/mc-make-cursor-here
;  "gzn" #'evil-mc-make-and-goto-next-cursor
;  "gzp" #'evil-mc-make-and-goto-prev-cursor
;  "gzN" #'evil-mc-make-and-goto-last-cursor
;  "gzP" #'evil-mc-make-and-goto-first-cursor)
; (with-eval-after-load 'evil-mc
;   (evil-define-key '(normal visual) evil-mc-key-map
;     (kbd "C-n") #'evil-mc-make-and-goto-next-cursor
;     (kbd "C-N") #'evil-mc-make-and-goto-last-cursor
;     (kbd "C-p") #'evil-mc-make-and-goto-prev-cursor
;     (kbd "C-P") #'evil-mc-make-and-goto-first-cursor))

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
  (setq projectile-switch-project-action #'projectile-dired)
  :bind
  ("C-s" . projectile-ripgrep))

;C-c p f이후 M-o하면 메뉴가 많아지는데 스크롤 방법을 모름.
;counsel-projectil-rg = c-p-s-r
(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package evil-nerd-commenter
:bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package python-mode
  :ensure nil
  :hook (python-mode . lsp-deferred) ;python mode켤때 lsp모드 켬
  :custom
  (python-shell-interpreter "python3")
  (dap-python-excutable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (require 'dap-python)
)

(use-package pyvenv
  :config
(pyvenv-mode 1))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(defun efs/lsp-mode-setup()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode)) ;위에 경로 보여주기

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package flymake-diagnostic-at-point
  ;:after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))
;(use-package flycheck
;  :ensure t
;  :init (global-flycheck-mode))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))
;:custom
;(lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

(use-package dap-mode
  ;기존에는 dap-auto-configure-feature변수에 sessions locals breakpoints expressions controls tooltip다보임
  ;그 중 몇개만 보려면 아래처럼 set
  ;:custom
  ;(dap-auto-configure-features '(sessions locals tooltip))

  ;breakpoint걸릴때마다 hydra띄우기
  :hook (dap-stopped . (lambda (arg) (call-interactively #'dap-hydra))))

;요거 python-mode에 추가함
;(dap-python-debugger 'debugpy)

;(dap-register-debug-template "My App"
;  (list :type "python"
;        :args "-i"
;        :cwd nil ; project root 설정
;        :env '(("DEBUG" . "1"))
;        :target-module (expand-file-name "~/src/myapp/.env/bin/myapp")
;        :request "launch"
;        :name "My App"))
;(dap-register-debug-template "Unit Test python"
;  (list :type "python"
;        :args "-i"
;        :cwd nil ; project root 설정
;        :env '(("DEBUG" . "1"))
;        :target-module (expand-file-name "~/src/myapp/.env/bin/myapp")
;        :request "launch"
;        :name "My App"))

;  breakpoint걸릴때마다 hydra띄우기
;  :hook (dap-stopped . (lambda (arg) (call-interactively #'dap-hydra))))

(use-package magit
  :ensure t)

;; -*- mode: emacs-lisp; tab-width: 8; -*-

;; Local Variables:
;; mode: emacs-lisp
;; tab-width: 8
;; eval; (eldoc-mode 0)
;; End:

(defun efs/org-mode-setup()
  (org-indent-mode)
  ;(variable-pitch-mode 1)
  ;(auto-fill-mode 0)
  (visual-line-mode 1))
  ;(setq evil-auto-indent nil))
                                        ;(use-package toc-org)

(use-package org
    :hook (org-mode . efs/org-mode-setup) ;훅을 쓰는 이유는 org buffer시작할때마다 위에설정 호출해서 그버퍼는 변수상태로 셋업하기 위함.
    :config
    (setq org-ellipsis " ▾" ; S-tab하면 ... 나오는걸 이걸로 바꾸기 위함
          org-hide-emphasis-markers t) ;bold link등 */같은거 안보이게
    (setq org-agenda-start-with-log-mode t)
    (setq org-log-done 'time)
    (setq org-log-into-drawer t)

    ;todo의 종류들을 추가하는 것으로 |기준으로 active냐 종료상태를 좌우로 나뉨
    (setq org-todo-keywords
          '((sequenct "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
            (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVITE(a)" "REVIEW(v)" "WAIT(w@/!)" "|" "COMPLETED(c)" "CANC(k@)")))
    (setq org-refile-targets
          '((nil :maxlevel . 1)
           (org-agenda-files :maxlevel . 1))))

    (if (eq system-type 'darwin)
        (setq org-agenda-files ; agenda에서 관리할 파일 리스트로 ""다음줄에 ""또넣어도됨
          '("~/.emacs.d/README.org"
            "~/workspace/org/tasks.org"))) ; '요거 하나는 뒤에가 리스트라는 의미로 펑션콜이 아님을 의미
    (setq org-startup-with-inline-images t) ; org에서 그림파일 항상 보이게

;(advice-add 'org-refile :after 'org-save-all-org-buffers)
;이렇게 하면 org-refile실행시 바로 org-save-all-org-buffers가 실행이됨

;스크린 캡처
(add-hook 'org-mode-hook
  (lambda ()
    (defun cam ()
      (interactive)
      (if buffer-file-name
        (progn
	  (message "Waiting for region selection with mouse ...")
	  (make-directory "./images/" t)
	  (let ((filename
	         (concat "./images/"
	                 (file-name-nondirectory buffer-file-name)
	               "_"
	               (format-time-string "%Y%m%d_%H%M%S")
	               ".png")))
	    (if (executable-find "scrot")
	        (call-process "scrot" nil nil nil "-s" filename)
	        (call-process "screencapture" nil nil nil "-s" filename))
	    (insert (concat "[[" filename "]]"))
	    (org-display-inline-images t t)
	  )
	  (message "File created and linked ...")
        )
        (message "You're in a not saved buffer! Save it first!")
      )
    )
  )
)
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)

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

(use-package org
:ensure org-plus-contrib)

(use-package org-notify
:ensure nil
:after org
:config
(org-notify-start)
(org-notify-add
 'default
 '(:time "10m" :period "5s" :duration 100 :actions -notify)
 '(:time "7m" :period "5s" :duration 50 :actions -notify/window))
(org-notify-add
 'reminder
 '(:time "10m" :period "5s" :duration 100 :actions -notify)))

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

(if (eq system-type 'darwin)
;이 파일을 저장하면 자동으로 tangle해서 저장하도록 하고싶다면
    (defun efs/org-babel-tangle-config ()
      (when (string-equal (buffer-file-name)
                      (expand-file-name "/Users/eddie/.emacs.d/init.org"))
        (let ((org-confirm-babel-evaluate nil))
          (org-babel-tangle)))))
(if (eq system-type 'gnu/linux)
;이 파일을 저장하면 자동으로 tangle해서 저장하도록 하고싶다면
    (defun efs/org-babel-tangle-config ()
      (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name "~/.emacs.d/"))
        (let ((org-confirm-babel-evaluate nil))
          (org-babel-tangle)))))
 (add-hook 'org-mode-hook (lambda ()(add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

;(push '("confi-unix" . confi-unix) org-src-lang-mode)

;(+ 55 100)

(if (eq system-type 'darwin)
(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000)))
(if (eq system-type 'gnu/linux)
(use-package vterm
  :commands vterm
  ;:load-path "~/.emacs.d/emacs-libvterm"
  :config
  (setq vterm-max-scrollback 10000)))

(defun efs/configure-eshell()
  ;;save command history
  (add-hock 'eshell-pre-command-hook 'eshell-save-some-history)
  ;; truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffers)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)
  (setq eshell-history-size 10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt)

(use-package eshell
  :hook (eshell-first-time-mode . efs/configure-eshell)
  :config
  (eshell-git-prompt-use-theme 'powerline))

(setq split-height-threshold nil)
(setq split-width-threshold 0)

(use-package buffer-move)

(use-package winner-mode
  :ensure nil
  :bind (:map evil-window-map
         ("u" . winner-undo)
         ("U" . winner-redo))
  :config
  (winner-mode))

(use-package ace-window)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(use-package winum
  :config
  (winum-mode))

;; Enable server mode (daemon) for this Emacs session
;(server-start)

;emacs --daemon=worker
;emacsclient -f worker -u -e "(org-babel-tangle-file \"~/.emacs.d/Emacs.org\")"
