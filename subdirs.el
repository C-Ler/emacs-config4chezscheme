(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (normal-top-level-add-subdirs-to-load-path))

(setq init-file-debug t)
(setq debug-on-error t)

;(defun fullpath-relative-to-call-location (file-path) (concat  (string-remove-suffix "site-lisp/" (file-name-directory (or load-file-name buffer-file-name)))  file-path))

(defun fullpath-relative-to-call-location (file-path) (concat (file-name-directory (or load-file-name buffer-file-name))  file-path))

(defalias 'fullpath 'fullpath-relative-to-call-location)

;(defvar init-path (fullpath "CFG/init.el"))

(load (fullpath "CFG/init.el"))


