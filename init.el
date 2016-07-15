;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy ;; elpy package for python
    ;; flycheck ;; pep8 checker
    exec-path-from-shell ;;
    material-theme
    fill-column-indicator  ;; 80 column ruler
    powerline
    git-gutter+
    )
  )

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(set-default-font "Monaco 16")
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
                                        ;
; (setq mac-command-modifier 'meta)
(setq backup-directory-alist
    (quote (("." . "~/.emacs.d/backups")))
)
(setenv "LC_CTYPE" "UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LANG" "en_US.UTF-8")
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(setq-default show-trailing-whitespace t) ; 显示行尾空格
(add-hook 'before-save-hook 'delete-trailing-whitespace) ; 自动删掉行尾空格
(setq-default indent-tabs-mode nil) ; 使用空格替代TAB
;; Makefile 需要TAB
(add-hook 'makefile-mode-hook 'indent-tabs-mode)
(setq column-number-mode t) ; 显示列号
(show-paren-mode t) ; 显示括号匹配
(setq x-stretch-cursor t)
(setq undo-outer-limit 5000000) ; 撤销次数的限制
(fset 'yes-or-no-p 'y-or-n-p)


(elpy-enable)
(elpy-use-ipython) ;; use ipython for elpy

;; Personal Helper functions
;; ---------------------------------------
;; clipboard sharing(OSX specific
 (defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))
(defun paste-to-osx(text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
(setq interprogram-paste-function 'copy-from-osx)
(setq interprogram-cut-function 'paste-to-osx)

(require 'powerline)
(powerline-default-theme)

; fill-column-indicator configs
(require 'fill-column-indicator)
(setq fci-rule-column 80)
; set fci-mode as a global minor mode
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)
(defvar-local company-fci-mode-on-p nil)

(defun company-turn-off-fci (&rest ignore)
    (when (boundp 'fci-mode)
          (setq company-fci-mode-on-p fci-mode)
              (when fci-mode (fci-mode -1))))

(defun company-maybe-turn-on-fci (&rest ignore)
    (when company-fci-mode-on-p (fci-mode 1)))

(add-hook 'company-completion-started-hook 'company-turn-off-fci)
(add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
(add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)

(global-git-gutter+-mode)

;; init.el ends here
(put 'upcase-region 'disabled nil)
