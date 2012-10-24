(defvar gcm-start-current-marker "<<<<<<<"
  "Marker used to mark current revision")

(defvar gcm-separate-revisions-marker "======="
  "Marker used to separate changes for both revions")

(defvar gcm-start-other-revision-marker ">>>>>>>"
  "Marker used to mark end of 'other' revision")

(defvar git-conflict-mode-map (make-sparse-keymap)
  "git-conflict-mode keymap")

(defun gcm-delete-line ()
  (delete-region (line-beginning-position)
                 (progn (forward-line 1) (point))))

(defun gcm-next-conflict ()
  (interactive)
  (if (search-forward-regexp gcm-start-current-marker nil t)
      (forward-line 1)
    (message "There is no next conflict")))

(defun gcm-previous-conflict ()
  (interactive)
  (move-end-of-line nil)
  (if (search-backward-regexp gcm-start-current-marker nil t 2)
      (forward-line 1)
    (message "There is no previous conflict")))

(defun gcm-use-theirs ()
  (interactive)
  (save-excursion
    (move-end-of-line nil)
    (delete-region (search-backward-regexp gcm-start-current-marker)
                   (search-forward-regexp gcm-separate-revisions-marker))
    (search-forward-regexp gcm-start-other-revision-marker)
    (gcm-delete-line)))

(defun gcm-use-mine ()
  (interactive)
  (save-excursion
    (move-end-of-line nil)
    (search-backward-regexp gcm-start-current-marker)
    (gcm-delete-line)
    (search-forward-regexp gcm-separate-revisions-marker)
    (delete-region (line-beginning-position)
                   (search-forward-regexp
                    (concat gcm-start-other-revision-marker ".+$")))))

(defun gcm-goto-their-changes ()
  (interactive)
  (search-forward-regexp gcm-separate-revisions-marker)
  (forward-line 1))

(define-key git-conflict-mode-map
  (kbd "C-c C-g ut") 'gcm-use-theirs)

(define-key git-conflict-mode-map
  (kbd "C-c C-g um") 'gcm-use-mine)

(define-key git-conflict-mode-map
  (kbd "<f11>") 'gcm-next-conflict)

(define-key git-conflict-mode-map
  (kbd "S-<f11>") 'gcm-previous-conflict)

(define-key git-conflict-mode-map
  (kbd "<F12>") 'gcm-goto-their-changes)

(define-minor-mode git-conflict-mode
  "Git Conflict Mode"
  nil
  " git-conflict"
  git-conflict-mode-map)

(provide 'git-conflict-mode)
