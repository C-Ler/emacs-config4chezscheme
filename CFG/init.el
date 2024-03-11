(message "Init init.el!")
;;-SET-ENVIRONMENT--------------------------------------------------------------------------------------------
(setq jinz-default-dir (concat default-directory "/CFG"))
(setq jinz-default-path (concat default-directory "/.."))
(setq source-directory (concat jinz-default-path "/28.2"))
(setq-default frame-title-format (concat "%b - e@" (system-name)))
(setq user-init-file jinz-default-path)
(setq user-emacs-directory jinz-default-dir)
(setenv "HOME" jinz-default-dir)
(setenv "PATH" jinz-default-path)
;; set the default file path
(add-to-list 'load-path jinz-default-dir)
					;下行用于解决slime无限polling的问题,根据提示设置缓存路径
					;(setq temporary-file-directory "C:/Users/___/AppData/Local/Temp/") 
;; window-system 表示是否为x窗体,其判断为:
;; (if window-system nil)
;; (if (not window-system) nil)
(setq sys/win32p nil)

;; system-type 表示系统类型
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (setq sys/win32p t)
    (message "Microsoft Windows") )
  )
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (message "Mac OS X"))
  )
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "Linux") ))
 )



