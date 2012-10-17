(let* ((current-directory (file-name-directory load-file-name))
       (features-directory (expand-file-name ".." current-directory))
       (project-directory (expand-file-name ".." features-directory)))
  (setq git-conflict-mode-root-path project-directory)
  (setq git-conflict-mode-util-path (expand-file-name "util" project-directory)))

(add-to-list 'load-path git-conflict-mode-root-path)
(add-to-list 'load-path (expand-file-name "espuds" git-conflict-mode-util-path))

(require 'git-conflict-mode)
(require 'espuds)
(require 'ert)

(Before
 (switch-to-buffer
  (get-buffer-create "*testing-buffer*"))
 (erase-buffer)
 (transient-mark-mode 1)
 (cua-mode 0)
 (git-conflict-mode 0)
 (setq set-mark-default-inactive nil)
 (deactivate-mark))

(After)
