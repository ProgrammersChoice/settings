;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "d2coding" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq doom-theme 'doom-gruvbox)

;;단축키
;;windows
;;spc-w-v
;;spc-w-c
;;spc-w-w 이동 위아래도됨kj
;;C-x 2 3 0 1 w
;;
;;파일찾기
;;spc-f-e
;;
;;easymotion
;;gss는  easymotion 두개단어
;;gsf는 한개단어 앞
;;gsF는 한개단어 뒤
;;gs/는 시간두고 하는것
;;
;;spc s p 는 Ag써서 프로젝트 검색
;;spc * 는 프로젝트에서 현재 심볼 검색 바로
;;
;;nerttree는 spc o p
;;
;;multicursor
;;gzz 커서하나만들기
;;gzj 커서하나만들기
;;gzk 커서하나만들기
;;
;;highlight
;;M-s h . 현재 단어 하이라이트
;;M-s h r 정규식 하이라이트
;;M-s h u 삭제
;;
;;minimap
;;M-x minimap SPC-t-m
;;
;;C-h-f 혹은 SPC-h-f 함수 헬프

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
