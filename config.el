;;;  -*- lexical-binding: t; -*-


;;
;; Keybindings
;;

(map!
 (:leader
   (:prefix "c"
     :desc "Format current buffer" :n "f" #'+functions/indent-region-or-buffer)))


;;
;; Modules
;;

;; tools/magit
(after! magit
  (setq magit-repository-directories
        (cl-loop for dir in (directory-files "~/Repositories" t "^[^.]" t)
                 if (file-directory-p dir)
                 nconc (cl-loop for subdir in (directory-files dir t "^[^.]" t)
                                if (and (file-directory-p subdir)
                                        (file-directory-p (expand-file-name ".git/" subdir)))
                                collect subdir))))

;; core/project
(after! projectile
  (when
      (require 'magit nil t)
    (mapc #'projectile-add-known-project
          (mapcar #'file-name-as-directory
                  (magit-list-repos)))
    (projectile-save-known-projects)))

