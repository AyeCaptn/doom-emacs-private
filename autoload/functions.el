;;;  -*- lexical-binding: t; -*-

;;;###autoload
(defun +functions/indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

;;;###autoload
(defun +functions/indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (+functions/indent-buffer)
        (message "Indented buffer.")))))

;;;###autoload
(defun +functions/find-monitor-attribute (&optional frame)
  "Return monitor-attributes alist on which FRAME exists."
  (let ((monitor)
        (monitors (display-monitor-attributes-list frame))
        (frame (selected-frame)))
    (catch 'found
      (while (setq monitor (car monitors))
        (if (member frame (assoc 'frames monitor))
            (throw 'found monitor)
          (setq monitors (cdr monitors)))))))

;;;###autoload
(defun +functions/find-monitor-width (&optional frame)
  "Return monitor width on which FRAME exists."
  (nth 2 (cdr (assoc 'workarea (+functions/find-monitor-attribute)))))

;;;###autoload
(defun +functions/find-monitor-height (&optional frame)
  "Return monitor height on which FRAME exists."
  (nth 3 (cdr (assoc 'workarea (+functions/find-monitor-attribute)))))

