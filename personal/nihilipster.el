;; GNU Emacs Common Lisp Emulation
(require 'cl-lib)

;; Packages
(prelude-require-packages
  '(modus-themes
     modus-operandi-theme
     gnu-elpa-keyring-update
     powerline
     airline-themes))

;; Color theme
(when (member 'modus-operandi package-selected-packages)
  (require 'modus-themes)
  (load-theme 'modus-operandi t)
  (setq prelude-theme (car custom-enabled-themes))
  ;; Disable theme background color in terminal
  ;;  set-face-background with window-setup-hook and after-make-frame-functions
  ;;  add a visual transition of the background color.
  (custom-theme-set-faces
    (car custom-enabled-themes)
      '(default ((t (:background nil))))))

;; Full path in title bar
(setq frame-title-format "%b (%f)")

;; Disable CIDER's REPL help banner
(setq cider-repl-display-help-banner nil)

;; Disable logging nREPL Communications
(setq nrepl-log-messages t)

;; Auto-Save Clojure Buffers on Load
(setq cider-save-file-on-load nil)

;; Disable auto focusing REPL buffer in its separated window
(setq cider-repl-pop-to-buffer-on-connect 'display-only)

;; Disable overlays entirely (and display results in the echo-area at the bottom)
(setq cider-use-overlays nil)

;; Hide Special nREPL Buffers
(setq nrepl-hide-special-buffers t)

;; Customizing CIDER's REPL prompt
(defun cider-repl-prompt-show-last-two (namespace)
  (let ((names (last (split-string namespace "\\.") 2)))
    (if (eq (seq-length names) 2)
      (concat "«" (nth 0 names) "." (nth 1 names) "» ")
      (concat "«" (nth 0 names) "» "))))
(setq cider-repl-prompt-function 'cider-repl-prompt-show-last-two)

;; CIDER can syntax highlight symbols that are known to be defined.
;; Also colorize usages of functions and variables from any namespace.
(setq cider-font-lock-dynamically '(macro core function var))

(add-hook 'cider-repl-mode-hook '(lambda ()
  ;; RainbowDelimiters is a minor mode which highlights parentheses, brackets,
  ;; and braces according to their depth. Each successive level is highlighted in
  ;; a different color. In CIDER's REPL.
  (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)))

;; Auto-trimming the REPL buffer
(setq cider-repl-buffer-size-limit 100000)

;; Powerline
(require 'powerline)
(require 'airline-themes)
(setq airline-hide-state-on-inactive-buffers t)
(setq airline-hide-eyebrowse-on-inactive-buffers t)
(setq airline-hide-vc-branch-on-inactive-buffers t)
(setq airline-eshell-colors t)
(setq airline-helm-colors t)
(setq airline-cursor-colors t)
(setq airline-display-directory t)
(setq airline-shortened-directory-length 30)
(setq airline-utf-glyph-separator-left #x20
      airline-utf-glyph-separator-right #x20
      airline-utf-glyph-subseparator-left #x20
      airline-utf-glyph-subseparator-right #x20)
(setq powerline-default-separator 'utf-8)
(setq powerline-utf-8-separator-left #x20
      powerline-utf-8-separator-right #x20)
(load-theme 'airline-light t)

;; Line Numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; Seconds to wait for an answer from the terminal.
;; Can be nil to mean "no timeout".
(setq xterm-query-timeout nil)

;; Disable flyspell-mode: spellchecking on the fly:
(setq prelude-flyspell nil)

;; Disable automatic formatting on save
(setq prelude-format-on-save nil)

