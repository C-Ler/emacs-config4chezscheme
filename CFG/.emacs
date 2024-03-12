;===========================================外观设置==================================
(global-display-line-numbers-mode)
(setq linum-format "%d")
(set-cursor-color "white") 
(set-mouse-color "blue") 
(set-foreground-color "green") 
(set-background-color "black") 
(set-border-color "lightgreen") 
(set-face-foreground 'highlight "red") 
(set-face-background 'highlight "lightblue") 
(set-face-foreground 'region "darkcyan") 
(set-face-background 'region "lightblue") 
(set-face-foreground 'secondary-selection "skyblue") 
(set-face-background 'secondary-selection "darkblue") 
;将帮助命令绑定到 F1键
(global-set-key [f1]   'help-command)
(global-set-key "\C-c\M-q" 'slime-reindent-defun)

;============================================编码方式设置==============================================
(set-language-environment "utf-8")
;; (set-locale-environment "UTF-8") 	;应对projectile-aq 查找出来的文件名称是乱码 2024年2月7日11:16:15
;注意,下行不能u8,否则打开汉语名文件不显示内容
(setq file-name-coding-system 'gb18030)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-next-selection-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-clipboard-coding-system 'utf-8)  
(setq ansi-color-for-comint-mode t)
(modify-coding-system-alist 'process "*" 'utf-8)  
(setq-default pathname-coding-system 'utf-8)  
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))  
(setq locale-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)  
(setq slime-net-coding-system 'utf-8-unix)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(prefer-coding-system 'utf-8)


;; ========================================环境设置==========================================
;; (setenv "PATH" "D:/ProgramData/bin")
(setq debug-on-error t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search nil)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "utf-8")
 '(package-archives
   '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
     ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
     ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
     ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")))
 '(package-selected-packages
   '(su grep-a-lot smex ## pos-tip ac-geiser auto-complete fuzzy popup geiser-chez embark consult cl-libify eglot eldoc faceup flymake jsonrpc org project soap-client verilog-mode ag projectile-codesearch seq magit elpy spinner markdown-mode lv let-alist ht cl-lib))
 '(safe-local-variable-values
   '((package . net.aserve.client)
     (package . net.aserve)
     (package . net.html.generator)))
 '(show-paren-mode t)
 '(text-mode-hook '(text-mode-hook-identify))
 '(uniquify-buffer-name-style 'forward nil (uniquify)))

(setq package-install-upgrade-built-in t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;===================================================smex配置===================================================================
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))

(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (delete-other-windows)
    (split-window-vertically (floor (* 0.68 (window-height))))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window 1))
   ((not (find "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))
               :test 'equal))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window -1))))

(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))


(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

(add-hook 'scheme-mode-hook
  (lambda ()
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))

;;=========================================自动开启paredit============================

;paredit需要一个el文件,代码可以在网上找到,放到和chezscheme同路径后可以启动这个插件,M-x paredit-mode启动,
;; (autoload 'paredit-mode "paredit"
;;   "Minor mode for pseudo-structurally editing Lisp code."
;;   t)

(use-package paredit
  :autoload paredit-mode		;展开为autoload xx "pack" t
  :hook scheme-mode-hook)


;;============================================= geiser 让emacs与scheme交流==================
;; (add-to-list 'load-path "~/.emacs.d/geiser/elisp")
;; (add-to-list 'load-path "~/.emacs.d/geiser-chez")
(use-package geiser-chez)

;; ==============================================代码自动补全==============================
;; ac的前件
;; (add-to-list 'load-path "~/.emacs.d/fuzzy-el")
;; (add-to-list 'load-path "~/.emacs.d/popup-el")
;; (add-to-list 'load-path "~/.emacs.d/pos-tip")
(use-package popup)
(use-package fuzzy)

;; (add-to-list 'load-path "~/.emacs.d/auto-complete")
(use-package company
  ;; :ensure t
  ;; :autoload company-mode
  :init
  (global-company-mode)
  :bind (
         :map company-active-map
              (("C-c n"   . company-select-next)
               ("C-p"   . company-select-previous)
               ("C-d"   . company-show-doc-buffer)
               ("<tab>" . company-complete)
	       ("M-/" . company-mode)
	       )
              )
  
  ;; :hook
  ;; after-init-hook
  :config
  (progn
    
    ;; (global-company-mode)
    (setq company-idle-delay 0
	  ompany-minimum-prefix-length 2)
    (setq company-backends
          '((company-dabbrev
             company-abbrev
             company-yasnippet
	     company-keywords
             )
	    (company-capf
	     ))
	  )
    )
  )


;; 使用增强的pos-tip
(use-package pos-tip
  :config
  (setq ac-quick-help-prefer-pos-tip t)
  )


;; =========================================== ac-geiser
;; (use-package ac-geiser
;;   :hook ((geiser-mode geiser-repl-mode) . ac-geiser-setup)   ;;因为会导致grep的bind失效,同时对company没什么助力,所以注释掉了....
;=======================================sbcl路径
;; (setq inferior-lisp-program "E:\\ProgramData\\SBCL\\sbcl.exe -K utf-8")
;多lisp实现时
;(setq slime-lisp-implementations
;	'((sbcl ("E:\\ProgramData\\SBCL\\sbcl.exe")))
;	  (ccl ("E:/ProgramData/ccl/wx86cl64.exe"))))
;slime路径
;; (add-to-list 'load-path "E:\\ProgramData\\slime\\")
;下行用于解决slime 无限polling的问题(通过根据提示设置缓存路径)
;(setq temporary-file-directory "E:\\Program Files\\emacs-24.3\\CFG") 
;自动加载slime全部,如果是'slime,会导致很多快捷键用不了
;; (require 'slime-autoloads)
;舒服的slime风格'(slime-fancy)，比如把sbcl的*变成CL-USER>
;; (add-to-list 'slime-contribs 'slime-fancy)
;(slime-setup '(slime-fancy
	      ; slime-asdf slime-banner))
;ccl路径
;(setq inferior-lisp-program "E:/ProgramData/ccl/wx86cl64.exe")

;;;======================================注意可移动模式，不然每次都要改
;;;关于scheme需要的包
;注意有时路径不对依旧可以启动scheme-mode
(add-to-list 'exec-path "C:\\Program Files\\Chez Scheme 10.0.0\\bin\\ta6nt")
;对于paredit编辑工具箱的加载路径设置,仿效slime设置了一波,ok了,后面的配置使它自动运行
(add-to-list 'load-path "C:\\Program Files\\Chez Scheme 10.0.0\\bin\\ta6nt")

;; scheme配置
(use-package cmuscheme
  :config					;照着SBCL更改了一下,效果很好;M-x scheme-mode 即可对一个buffer开启scheme模式
  (setq scheme-program-name "scheme"))


;; ==============================================magit========================
;; (add-to-list 'load-path "~/.emacs.d/magit") ;or directory, dash没有  2023年3月24日20:11:30
;; (require 'magit)
;; (add-to-list 'load-path "~/.emacs.d/openai")
;; (require 'chatgpt)

;; ============================================elpy==========================
(require 'elpy)

;; =================================consult========================================
(use-package consult
  :defer t
  :init
  (if (eq system-type 'window-nt)
      (progn
	;; (add-to-list 'default-process-coding-system-alist '("grep" . (utf-8 . utf-8)))
        (add-to-list 'process-coding-system-alist '("es" utf-8 . utf-8))
	(add-to-list 'process-coding-system-alist '("rg" utf-8 . utf-8))
        (add-to-list 'process-coding-system-alist '("explorer" utf-8 . utf-8))
	(add-to-list 'process-coding-system-alist '("grep" utf-8 . utf-8))
	(add-to-list 'process-coding-system-alist '("cmd" utf-8 . utf-8))
        (setq consult-locate-args (encode-coding-string "es.exe -i -p -r -n" 'utf-8))
	(setq consult-locate-args (encode-coding-string "grep.exe -p -r -n" 'utf-8)))
    )

  (advice-add #'multi-occur :override #'consult-multi-occur)
  (advice-add #'consult-line
              :around
              #'zilongshanren/consult-line
              '((name . "wrapper")))

  :bind ("C-c r e" . consult-grep)
  
  :config
  (progn
    (global-set-key (kbd "M-y") 'consult-yank-pop)
    (setq ;; consult-project-root-function #'doom-project-root
     consult-narrow-key "<"
     consult-line-numbers-widen t
     consult-async-min-input 2
     consult-async-refresh-delay  0.15
     consult-async-input-throttle 0.2
     consult-async-input-debounce 0.1))


  ;; (consult-customize
  ;;  consult-ripgrep consult-git-grep consult-grep
  ;;  consult-bookmark consult-recent-file
  ;;  :preview-key (kbd "C-SPC"))

  ;; (consult-customize
  ;;  consult-theme
  ;;  :preview-key (list (kbd "C-SPC") :debounce 0.5 'any))
  )

(use-package magit
  :bind ("C-c m s" . magit-status)
  )

(use-package color-rg
  :bind ("C-c c r" . color-rg-search-input)
  )



