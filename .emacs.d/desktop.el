(defun efs/run-in-background (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

  ;; --bg-scale은 전체를 체우겠다는 의미
(defun efs/set-wallpaper()
  (interactive)
  (start-process-shell-command "feh" nil "feh --bg-scale ~/.emacs.d/newyork8k2.jpg"))

(defun efs/exwm-init-hook ()
  ;; Make workspace 1 be the one where we land at startup
  (exwm-workspace-switch-create 1)

  ;; enable polybar
  ;;(efs/start-panel)

  (efs/run-in-background "nm-applet") ;시스템 트레이에 네트워크 아이콘 보이게
  (efs/run-in-background "pasystray") ;시스템 트레이에서 볼륨조절
  (efs/run-in-background "blueman-applet")) ;시스템 트레이에 블루투스 아이콘 보이게

;버퍼 이름을 프로그램 이름으로 하는 함수
(defun efs/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

(defun efs/exwm-update-title ()
  (pcase exwm-class-name
    ("Firefox" (exwm-workspace-rename-buffer (format "Firefox: %s" exwm-title)))))

(defun efs/configure-window-by-class ()
  (interactive)
  ;(message ("Window '%s' appeared!" exwm-class))
  (pcase exwm-class-name
    ;("Firefox" (exwm-workspace-move-window 2))
    ;("Sol" (exwm-workspace-move-window 3))
    ("mpv" (exwm-floating-toggle-floating)
           (exwm-layout-toggle-mode-line))))

(defun efs/update-displays ()
  (efs/run-in-background "autorandr --change --force")
  (efs/set-wallpaper)
  (message "Display config: %s"
           (string-trim (shell-command-to-string "autorandr --current"))))


(use-package exwm
  :config
  ;; Set the default number of workspaces
  (setq exwm-workspace-number 5)

  ;; When window "class" updates, use it to set the buffer name
  (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

  ;; When window title updates, use it to set the buffer name
  (add-hook 'exwm-update-title-hook #'efs/exwm-update-title)

  ;; Configure windows as they're created
  (add-hook 'exwm-manage-finish-hook #'efs/configure-window-by-class)

  ;; Automatically move EXWM buffer to curren workspace when selected
  (setq exwm-layout-show-all-buffers t)

  ;; Display all EXWM buffers in every workspace buffer list
  (setq exwm-workspace-show-all-buffers t)

  ;; Rebind CapsLock to Ctrl
  ;(start-process-shell-command "xmodmap" nil "xmodmap ~/.emacs.d/exwm/Xmodmap")
  (require 'exwm-randr)
  (exwm-randr-enable)
  ;(start-process-shell-command "xrandr" nil "xrandr --output Virtual-1 --primary --mode 2560x1600 --pos 0x0 --rotate normal")

  ;multi monitor
  ;; Use only one monitor
  ;(start-process-shell-command "xrandr" nil "xrandr --output VGA-0 --off output DVI-D-0 --off --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate right --output VGA-1-1 --off --output HDMI-1-1 --off --output DP-1-1 --off")

  ;; Use two monitor
  (start-process-shell-command "xrandr" nil "xrandr --output VGA-0 --off --output DVI-D-0 --mode 2560x1440 --pos 2160x755 --rotate normal --output HDMI-0 --primary --mode 2560x1440 --pos 0x0 --rotate right --output VGA-1-1 --off --output HDMI-1-1 --off --output DP-1-1 --off")
  (setq exwm-randr-workspace-monitor-plist '(0 "HDMI-0" 1 "HDMI-0" 2 "HDMI-0" 3 "DVI-D-0" 4 "DVI-D-0" 5 "DVI-D-0" 6 "DVI-D-0" 7 "DVI-D-0" 8 "DVI-D-0" 9 "DVI-D-0"))

  ;; react to display connectivity change, do initial display update
  (add-hook 'exwm-randr-screen-change-hook #'efs/update-displays)
  (efs/update-displays)

  ;; 마우스 커서가 윈도우 따라가게
  (setq exwm-workspace-wrap-cursor t)
  ;; 마우스 커서따라 포커스 따라가게
  (setq mouse-autoselect-window t
        focus-follows-mouse t)

  ;; These keys should always pass through to Emacs
  (setq exwm-input-prefix-keys
    '(?\C-x
      ?\C-u
      ?\C-h
      ?\M-x
      ?\M-`
      ?\M-&
      ?\M-:
      ?\C-\M-j  ;; Buffer list
      ?\C-\   ;; Ctrl+Space
      )) ;; Ctrl + \\

  ;; Ctrl+Q will enable the next key to be sent directly
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

  ;; Set up global key bindings.  These always work, no matter the input state!
  ;; Keep in mind that changing this list after EXWM initializes has no effect.
  (setq exwm-input-global-keys
        `(
          ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
          ([?\s-r] . exwm-reset)

          ;; Move between windows
          ([s-left] . windmove-left)
          ([s-right] . windmove-right) ;C-h v desktop-environment-mode-map desktop-environment-lock-screen to cancel the C-l
          ([s-up] . windmove-up)
          ([s-down] . windmove-down)

         ;; Launch applications via shell command
          ([?\s-&] . (lambda (command)
                       (interactive (list (read-shell-command "$ ")))
                       (start-process-shell-command command nil command)))

          ;; Switch workspace
          ([?\s-w] . exwm-workspace-switch)
          ([?\s-`] . (lambda () (interactive) (exwm-workspace-switch-create 0)))

          ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i)) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))))

  (if (eq system-type 'gnu/linux)
    (exwm-enable))
  )

(push ?\C-\\ exwm-input-prefix-keys)
(require 'exwm-xim)
(exwm-xim-enable)

(use-package desktop-environment
  :after exwm
  :config (desktop-environment-mode)
  :custom
  (desktop-environment-brightness-small-increment "2%+")
  (desktop-environment-brightness-small-decrement "2%-")
  (desktop-environment-brightness-normal-increment "5%+")
  (desktop-environment-brightness-normal-decrement "5%-"))

;modeline에 정보 보여주기
(display-battery-mode 1)
(setq display-time-day-and-date t)
;(setq dislpay-time-format "%m/%d/%y")
(display-time-mode 1)

(setq tab-bar-new-tab-choice "*scratch*")

(setq tab-bar-close-button-show nil
      tab-bar-new-button-show nil)

;; Don't turn on tab-bar-mode when tabs are created
;(setq tab-bar-show nil)

;; Get the current tab name for use in some other display
(defun efs/current-tab-name ()
  (alist-get 'name (tab-bar--current-tab)))

;  (use-package edwina
;    :ensure t
;    :config
;    (setq display-buffer-base-action '(display-buffer-below-selected))
;    ;; (edwina-setup-dwm-keys)
;    (edwina-mode 1))

;; Make sure the server is started (better to do this in your main Emacs config!)
(server-start)

(defvar efs/polybar-process nil
  "Holds the process of the running Polybar instance, if any")

(defun efs/kill-panel ()
  (interactive)
  (when efs/polybar-process
    (ignore-errors
      (kill-process efs/polybar-process)))
  (setq efs/polybar-process nil))

(defun efs/start-panel ()
  (interactive)
  (efs/kill-panel)
  (setq efs/polybar-process (start-process-shell-command "polybar" nil "polybar panel")))

(defun efs/send-polybar-hook (module-name hook-index)
  (start-process-shell-command "polybar-msg" nil (format "polybar-msg hook %s %s" module-name hook-index)))

(defun efs/send-polybar-exwm-workspace ()
  (efs/send-polybar-hook "exwm-workspace" 1))

;; Update panel indicator when workspace changes
(add-hook 'exwm-workspace-switch-hook #'efs/send-polybar-exwm-workspace)

;; Start the Polybar panel
(if (eq system-type 'gnu/linux)
  (efs/start-panel)
)

;; Make sure the server is started (better to do this in your main Emacs config!)
;; (server-start)

(defun efs/polybar-exwm-workspace ()
  (pcase exwm-workspace-current-index
    (0 "")
    (1 "")
    (2 "")
    (3 "")
    (4 "")))
