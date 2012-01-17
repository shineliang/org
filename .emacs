(server-start)

(setq load-path (cons "/cygdrive/d/org-7.8.03/lisp" load-path))
(setq load-path (cons "/cygdrive/d/org-7.8.03/contrib/lisp" load-path))
(add-to-list 'load-path "~/.emacs.d/")

(require 'cygwin-mount) 
(cygwin-mount-activate) 

(if (functionp 'tool-bar-mode) (tool-bar-mode nil))

(require 'xcscope)
(add-hook 'java-mode-hook (function cscope:hook))
;; org-mode related configuration
(require 'org-install)

;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done 'time)

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

(if (file-directory-p "/cygdrive/d/cygwin/bin")
    (add-to-list 'exec-path "/cygdrive/d/cygwin/bin"))

(setq shell-file-name "bash")
(setq explicit-shell-file-name shell-file-name)

(cond  ((eq window-system 'w32)
	(setq tramp-default-method "scpx"))
       (t
	(setq tramp-default-method "scpc")))


(add-hook 'comint-output-filter-functions
    'shell-strip-ctrl-m nil t)
(add-hook 'comint-output-filter-functions
    'comint-watch-for-password-prompt nil t)

(setq org-directory "/cygdrive/c/Documents and Settings/shine_zhong/My Documents/Dropbox/org")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(global-auto-revert-mode t)
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("/cygdrive/c/Documents and Settings/shine_zhong/My Documents/Dropbox/org/gtd.org")))
 '(org-capture-templates (quote (("t" "Todo" entry (file+headline "/cygdrive/c/Documents and Settings/shine_zhong/My Documents/Dropbox/org/gtd.org" "Tasks") "* TODO %?
  %i
  %a"))))
 '(org-export-html-style "<link rel=\"stylesheet\" title=\"Standard\" href=\"style/worg.css\" type=\"text/css\" />
<link rel=\"alternate stylesheet\" title=\"Zenburn\" href=\"style/worg-zenburn.css\" type=\"text/css\" />
<link rel=\"alternate stylesheet\" title=\"Classic\" href=\"style/worg-classic.css\" type=\"text/css\" />
<link rel=\"stylesheet\" href=\"style/lightbox.css\" type=\"text/css\" media=\"screen\" />")
 '(org-icalendar-alarm-time 10)
 '(org-icalendar-include-todo t)
 '(org-icalendar-store-UID t)
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 2))))
;; '(server-done-hook (quote ((lambda nil (kill-buffer nil)) delete-frame)))
;; '(server-switch-hook (quote ((lambda nil (let (server-buf) (setq server-buf (current-buffer)) (bury-buffer) (switch-to-buffer-other-frame server-buf))))))
)

(setq current-language-environment "UTF-8")  
(setq default-input-method "chinese-py")  
(setq locale-coding-system 'utf-8)  
(set-terminal-coding-system 'utf-8)  
(set-keyboard-coding-system 'utf-8)  
(set-selection-coding-system 'utf-8)  
(prefer-coding-system 'utf-8)  

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(defun gtd ()
  (interactive)
  (find-file (concat org-directory "/gtd.org"))
  )
(define-key global-map "\C-cg" 'gtd)

(defun open-key-info-file ()  
  (interactive)  
  (split-window-horizontally)  
  (find-file-other-window (concat org-directory "/emacskeys.org"))
  (hide-body))  

(global-set-key "\C-hz" 'open-key-info-file)  
(define-key global-map "\C-cc" 'org-capture)

(defun wl-org-agenda-to-appt ()
  ;; Dangerous!!!  This might remove entries added by `appt-add' manually. 
  (org-agenda-to-appt t "TODO"))

(appt-activate 1)

(wl-org-agenda-to-appt)
(defadvice  org-agenda-redo (after org-agenda-redo-add-appts)
  "Pressing `r' on the agenda will also add appointments."
  (progn
    (let ((config (current-window-configuration)))
      (appt-check t)
      (set-window-configuration config))
    (wl-org-agenda-to-appt)))

(ad-activate 'org-agenda-redo)