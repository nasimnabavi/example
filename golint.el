;;; golint.el --- linter/problem finder for the Go source code

;; URL: https://godoc.org/golang.org/x/tools/cmd/vet

;;; Commentary:

;; To install golint, add the following lines to your .emacs file:
;;   (add-to-list 'load-path "PATH CONTAINING golint.el" t)
;;   (require 'golint)
;;
;; After this, type M-x golint on Go source code.
;;
;; Usage:
;;   C-x `
;;     Jump directly to the line in your code which caused the first message.
;; 
;;   For more usage, see Compilation-Mode:
;;     http://www.gnu.org/software/emacs/manual/html_node/emacs/Compilation-Mode.html

;;;; THIS IS BASICALLY ENTIRELY COPIED AND SLIGHTLY MODIFIED FROM THE GOLINT EMACS MODE
;;;; https://github.com/golang/lint/tree/master/misc/emacs

;;; Code:
(require 'compile)

(defun go-vet-buffer-name (mode) 
 "*goLint*") 

(defun golint-process-setup ()
  "Setup compilation variables and buffer for `golint'."
  (run-hooks 'golint-setup-hook))

(define-compilation-mode golint-mode "golint"
  "goLint is a veter for Go source code."
  (set (make-local-variable 'compilation-scroll-output) nil)
  (set (make-local-variable 'compilation-disable-input) t)
  (set (make-local-variable 'compilation-process-setup-function)
       'golint-process-setup)
)

;;;###autoload
(defun golint ()
  "Run golint on the current file and populate the fix list. Pressing C-x ` will jump directly to the line in your code which caused the first message."
  (interactive)
  (compilation-start
   (concat "go vet " (mapconcat #'shell-quote-argument
                               (list (expand-file-name buffer-file-name)) " "))
   'golint-mode))

(provide 'golint)

;;; golint.el ends here

