;; Start-up
	;; Don't show the splash screen
	(setq inhibit-startup-message t)
	;; Load the previous configuration
	(desktop-save-mode 1)
	;; Load theme
	(load-theme 'deeper-blue t)
	;; Set font size
	(set-face-attribute 'default nil :height 200)

	;; Set frame transparency
	(defvar efs/frame-transparency '(90 . 90))
	(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
	(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
	(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
	(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; Some trivial configuration options
	;; Toggle visible bell
	(setq visible-bell t)

	;; Display line numbers
	(global-display-line-numbers-mode 1)
	;; Disable line numbers for some modes
	(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
	  (add-hook mode (lambda () (display-line-numbers-mode 0))))

	;; Log all commands.
	(use-package command-log-mode)

	;; Menubar, Scrollbar, Toolbar
	(menu-bar-mode 1)
	(tool-bar-mode -1)
	(scroll-bar-mode 1)
	(set-fringe-mode 10)

	(column-number-mode)


;; Packages
	;; Initialize package sources
		(require 'package)
		(setq package-archives '(("melpa" . "https://melpa.org/packages/")
				 ("gnu" . "https://elpa.gnu.org/packages/")
				 ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
	
	
		(package-initialize)
		(unless package-archive-contents
		  (package-refresh-contents))
	
	;; Initialize use-package on non-Linux platforms
		(unless (package-installed-p 'use-package)
		  (package-install 'use-package))
	
		(require 'use-package)
		(setq use-package-always-ensure t)
	
	(use-package command-log-mode)

	;; I don't know
		(setq package-archive-contents t)
		(custom-set-variables
		 ;; custom-set-variables was added by Custom.
		 ;; If you edit it by hand, you could mess it up, so be careful.
		 ;; Your init file should contain only one such instance.
		 ;; If there is more than one, they won't work right.
		 '(package-selected-packages
		   '(dap-python which-key use-package lsp-ui lsp-ivy dap-mode command-log-mode)))
		(custom-set-faces
		 ;; custom-set-faces was added by Custom.
		 ;; If you edit it by hand, you could mess it up, so be careful.
		 ;; Your init file should contain only one such instance.
		 ;; If there is more than one, they won't work right.
		 )

	
	;; Org mode: allow tab to collapse tree,
	;; even while the cursor is inside the tree
		(setq org-cycle-emulate-tab 'white)
	
	
	;; Which-key integration
		(use-package which-key
		  :init (which-key-mode)
		  :diminish which-key-mode
		  :config
		  (setq which-key-idle-delay 1))
	
	
	;; Ivy settings
		(use-package ivy
		  :diminish
		  :bind (;("C-s" . swiper)
		         ;:map ivy-minibuffer-map
		         ;("TAB" . ivy-alt-done)	
		         ;("C-l" . ivy-alt-done)
		         ;("C-j" . ivy-next-line)
		         ;("C-k" . ivy-previous-line)
		         ;:map ivy-switch-buffer-map
		         ;("C-k" . ivy-previous-line)
		         ;("C-l" . ivy-done)
		         ;("C-d" . ivy-switch-buffer-kill)
		         ;:map ivy-reverse-i-search-map
		         ;("C-k" . ivy-previous-line)
			 ;("C-d" . ivy-reverse-i-search-kill)
			 )
		  :config
		  (ivy-mode 1))
	
		;;  (use-package ivy-rich
		;;    :init
		;;    (ivy-rich-mode 1))
	
	
	
	;; enable this if you want `swiper' to use it
	;; (setq search-default-mode #'char-fold-to-regexp)
	;(global-set-key "\C-s" 'swiper)
	;(global-set-key (kbd "C-c C-r") 'ivy-resume)
	;(global-set-key (kbd "<f6>") 'ivy-resume)
	;(global-set-key (kbd "M-x") 'counsel-M-x)
	;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
	;(global-set-key (kbd "<f1> f") 'counsel-describe-function)
	;(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
	;(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
	;(global-set-key (kbd "<f1> l") 'counsel-find-library)
	;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
	;(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
	;(global-set-key (kbd "C-c g") 'counsel-git)
	;(global-set-key (kbd "C-c j") 'counsel-git-grep)
	;(global-set-key (kbd "C-c k") 'counsel-ag)
	;(global-set-key (kbd "C-x l") 'counsel-locate)
	;(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
	;(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
	
	(defun efs/lsp-mode-setup ()
	    (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
	    (lsp-headerline-breadcrumb-mode))

;; Programming
	;; lsp mode
		(use-package lsp-mode
		  :init
		  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
		  (setq lsp-keymap-prefix "C-c l")
		  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
		         (python-mode . lsp)
		         ;; if you want which-key integration
		         (lsp-mode . lsp-enable-which-key-integration)
			 (lsp-mode . efs/lsp-mode-setup)
			 )
		  :commands lsp)
	
	;; lsp ui mode
		(use-package lsp-ui
		  :hook (lsp-mode . lsp-ui-mode)
		  :custom
		    (lsp-ui-doc-position 'bottom)
		    )
		;; if you are ivy user
		(use-package lsp-ivy
		  :commands lsp-ivy-workspace-symbol)
		(use-package lsp-treemacs
		  :after lsp
		  :commands lsp-treemacs-errors-list)
			;; The modes below are optional
		
		(dap-ui-mode 1)
		;; enables mouse hover support
		(dap-tooltip-mode 1)
		;; use tooltips for mouse hover
		;; if it is not enabled `dap-mode' will use the minibuffer.
		(tooltip-mode 1)
		;; displays floating panel with debug buttons
		;; requires emacs 26+
		(dap-ui-controls-mode 1)
	
		;; optionally if you want to use debugger
		;(require 'dap-python)
		
		;(use-package dap-mode
		;  :after lsp-mode
		;  :commands dap-debug
		;  :hook ((python-mode . dap-ui-mode)
		;	 (python-mode . dap-mode))
		;  :config
		;  (eval-when-compile
		;    (require 'cl))
		;  (require 'dap-python)
		;  (require 'dap-lldb)
		;
		;  ;; Temporal fix
		;  (defun dap-python--pyenv-executable-find (command)
		;    (with-venv (executable-find "python")))
		;  )


	;; dap mode
	(use-package dap-mode
	    ;; Uncomment the config below if you want all UI panes to be hidden by default!
	    ;; :custom
	    ;; (lsp-enable-dap-auto-configure nil)
	    ;; :config
	    ;; (dap-ui-mode 1)
	
	    :config
	    ;; Set up Node debugging
	    (require 'dap-node)
	    (dap-node-setup) ;; Automatically installs Node debug adapter if needed
	
	;    ;; Bind `C-c l d` to `dap-hydra` for easy access
	;    (general-define-key
	;      :keymaps 'lsp-mode-map
	;      :prefix lsp-keymap-prefix
	;      "d" '(dap-hydra t :wk "debugger"))
	    )

	;; Python
		(use-package python-mode
		  :ensure t
		  :hook (python-mode . lsp-deferred)
		  :custom
		  ;; NOTE: Set these if Python 3 is called "python3" on your system!
		   (python-shell-interpreter "python3")
		   (dap-python-executable "python3")
		  (dap-python-debugger 'debugpy)
		  :config
		  (require 'dap-python))
		
		(use-package pyvenv
		  :config
		  (pyvenv-mode 1))

	;; Company mode
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

	;; Projectile
		(add-to-list 'load-path "/home/dave/.emacs.d/elpa/projectile-20220705.1255")
(require 'projectile)
(setq debug-on-error t)
		(use-package projectile
		  :diminish projectile-mode
		  ;;:config (projectile-mode)
		  :custom ((projectile-completion-system 'ivy))
		  :bind-keymap
		  ("C-c p" . projectile-command-map)
		  ;;:init
		  ;; NOTE: Set this to the folder where you keep your Git repos!
		;;  (when (file-directory-p "~/Projects/Code")
		    ;;(setq projectile-project-search-path '("~/Projects/Code")))
		  ;;(setq projectile-switch-project-action #'projectile-dired)
		 )
		(projectile-global-mode)
		(setq projectile-enable-caching t)
		(setq projectile-project-search-path '("~/PycharmProjects/"
					   "~/AndroidStudioProjects/"
					    "~/eclipse-workspace/"
					    "~/.emacs.d/bin/"
					    "~/bin/")
		  )
		;(use-package counsel-projectile
		;  :config (counsel-projectile-mode))
	
	;; Magit
		(use-package magit
		  :custom
		  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
			
	(use-package rainbow-delimiters
	  :hook (prog-mode . rainbow-delimiters-mode))
	;; (add-to-list 'eshell-visual-subcommands ("git" "log" "diff" "show"))
	
	
	
