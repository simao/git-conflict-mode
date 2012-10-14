(defvar git-conflict-mode-map (make-sparse-keymap)
  "git-conflict-mode keymap")

(defun gcm-delete-line ()
  (delete-region (line-beginning-position)
                 (progn (forward-line 1) (point))))

(defun gcm-next-conflict ()
  (interactive)
  (search-forward-regexp "<<<<<<<")
  (forward-line 1))

(defun gcm-previous-conflict ()
  (interactive)
  (move-end-of-line nil)
  (search-backward-regexp "<<<<<<<" nil nil 2)
  (forward-line 1)
  )

(defun gcm-use-theirs ()
  (interactive)
  (save-excursion
    (move-end-of-line nil)
    (delete-region (search-backward-regexp "<<<<<<<")
                   (search-forward-regexp "======="))
    (search-forward-regexp ">>>>>>>")
    (gcm-delete-line)
    ))

(defun gcm-use-mine ()
  (interactive)
  (save-excursion
    (move-end-of-line nil)
    (search-backward-regexp "<<<<<<<")
    (gcm-delete-line)
    (search-forward-regexp "=======")
    (delete-region (line-beginning-position)
                   (search-forward-regexp ">>>>>>>.+$"))
    ))

(defun gcm-goto-their-changes ()
  (interactive)
  (search-forward-regexp "=======")
  (forward-line 1))

(define-key git-conflict-mode-map
  (kbd "C-c C-g ut") 'gcm-use-theirs)

(define-key git-conflict-mode-map
  (kbd "C-c C-g um") 'gcm-use-mine)

(define-key git-conflict-mode-map
  (kbd "C-c C-g nc") 'gcm-next-conflict)

(define-key git-conflict-mode-map
  (kbd "C-c C-g pc") 'gcm-previous-conflict)

(define-key git-conflict-mode-map
  (kbd "C-c C-g tc") 'gcm-goto-their-changes)

(define-minor-mode git-conflict-mode
  "Git Conflict Mode"
  nil
  " git-conflict"
  git-conflict-mode-map)

(provide 'git-conflict-mode)
