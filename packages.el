;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Speed improvements
(package! gcmh)

;; UI packages
(package! solaire-mode :disable t)

(package! spacious-padding)

(package! rainbow-delimiters)

(package! breadcrumb)

(package! whitespace4r :recipe
  (:host github
   :repo "twlz0ne/whitespace4r.el"
   :files ("whitespace4r.el")))

;; Org packages - using tecosaur's fork
(package! org :recipe
  (:host nil
   :repo "https://git.tecosaur.net/mirrors/org-mode.git "
   :remote "mirror"
   :fork (:host nil
          :repo "https://git.tecosaur.net/tec/org-mode.git "
          :branch "dev"
          :remote "tecosaur")
   :files (:defaults "etc")
   :build t
   :pre-build
   (with-temp-file "org-version.el"
     (require 'lisp-mnt)
     (let ((version (with-temp-buffer
                      (insert-file-contents "lisp/org.el")
                      (lm-header "version")))
           (git-version
            (string-trim
             (with-temp-buffer
               (call-process "git" nil t nil "rev-parse" "--short" "HEAD")
               (buffer-string)))))
       (insert
        (format "(defun org-release () \"The release version of Org.\" %S)\n" version)
        (format "(defun org-git-version () \"The truncate git commit hash of Org mode.\" %S)\n" git-version)
        "(provide 'org-version)\n"))))
  :pin nil)

(unpin! org)

(package! org-roam-ui)

(package! org-modern-indent :recipe
  (:host github
   :repo "jdtsmith/org-modern-indent"))

(package! valign)

;; Language-specific packages
(package! arduino-mode)

(package! nasm-mode)

;; LLM integration
(package! llm-tool-collection
  :recipe (:host github :repo "skissue/llm-tool-collection"))

;; Calendar (cross-platform)
(unpin! calfw)

(package! calfw :recipe
  (:host github
   :repo "kiwanami/emacs-calfw"
   :fork (:repo "haji-ali/emacs-calfw"
          :fork (:repo "michaelneuper/emacs-calfw"
                 :branch "fix"))))

(package! calfw-blocks :recipe
  (:host github
   :repo "haji-ali/calfw-blocks"
   :fork (:repo "michaelneuper/calfw-blocks"
          :branch "fix-dispatch-and-colors")))
