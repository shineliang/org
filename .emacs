(tool-bar-mode 0)
(add-to-list 'load-path 
           "~/.emacs.d/yasnippet-0.6.1c") 
(require 'yasnippet) ;; not yasnippet-bundle 
(yas/initialize) 
(yas/load-directory "~/.emacs.d/yasnippet-0.6.1c/snippets")

(add-to-list 'load-path "~/.emacs.d/")

(server-start)

(require 'xcscope)
(add-hook 'java-mode-hook (function cscope:hook))
;; org-mode related configuration
(require 'org-install)
;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;;(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done 'time)

;;(require 'zenburn)
;;(color-theme-zenburn)

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line"
  (interactive "P")
  (let ((beg (line-beginning-position)) 
	(end (line-end-position arg)))
    (copy-region-as-kill beg end))
  )

(defun copy-word (&optional arg)
  "Copy words at point"
  (interactive "P")
  (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point))) 
	(end (progn (forward-word arg) (point))))
    (copy-region-as-kill beg end))
  )

(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (let ((beg (progn (backward-paragraph 1) (point))) 
	(end (progn (forward-paragraph arg) (point))))
    (copy-region-as-kill beg end))
  )

(if (file-directory-p "d:/cygwin/bin")
    (add-to-list 'exec-path "d:/cygwin/bin"))

(setq shell-file-name "bash")
(setq explicit-shell-file-name shell-file-name)

;; set tramp-default-method to “sshx” or “scpx”
(cond  ((eq window-system 'w32)
	(setq tramp-default-method "scpx"))
       (t
	(setq tramp-default-method "scpc")))


(add-hook 'comint-output-filter-functions
    'shell-strip-ctrl-m nil t)
(add-hook 'comint-output-filter-functions
    'comint-watch-for-password-prompt nil t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("c:/Documents and Settings/shine_zhong/My Documents/Dropbox/org/gtd.org")))
 '(org-export-html-style "<link rel=\"stylesheet\" title=\"Standard\" href=\"style/worg.css\" type=\"text/css\" />
<link rel=\"alternate stylesheet\" title=\"Zenburn\" href=\"style/worg-zenburn.css\" type=\"text/css\" />
<link rel=\"alternate stylesheet\" title=\"Classic\" href=\"style/worg-classic.css\" type=\"text/css\" />
<link rel=\"stylesheet\" href=\"style/lightbox.css\" type=\"text/css\" media=\"screen\" />")
 '(server-done-hook (quote ((lambda nil (kill-buffer nil)) delete-frame)))
 '(server-switch-hook (quote ((lambda nil (let (server-buf) (setq server-buf (current-buffer)) (bury-buffer) (switch-to-buffer-other-frame server-buf)))))))
	
	
(set-terminal-coding-system 'chinese-iso-8bit)
(set-keyboard-coding-system 'chinese-iso-8bit)
(set-language-environment 'Chinese-GB)
(setq locale-coding-system 'chinese-iso-8bit)
(setq current-language-environment "Chinese-GB")

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(defun gtd ()
  (interactive)
  (find-file "c:/Documents and Settings/shine_zhong/My Documents/Dropbox/org/gtd.org")
  )

(require 'w3m-load)  
(setq w3m-use-favicon nil)  
(setq w3m-command-arguments '("-cookie" "-F"))  
(setq w3m-use-cookies t)  ;打开cookie支持  
(setq w3m-home-page "www.google.com")  ;设置主页  
(setq w3m-default-display-inline-image t) ;显示图片  
(setq w3m-default-toggle-inline-images t)  