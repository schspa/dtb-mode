;;; dtb-mode.el --- Show device tree souce in dtbs -*- lexical-binding: t -*-

;; Copyright (C) 2020 Schspa Shi

;; Author: Schspa Shi <schspa@gmail.com>
;; URL: https://github.com/schspa/dtb-mode
;; Package-Version: 20201223.2037
;; Package-Requires: ((emacs "25"))
;; Version: 1.0
;; Keywords: dtb dts convenience

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Toggle `dtb-mode' to show the symbols that the binary uses instead
;; of the actual binary contents.
;;
;; References:
;;    https://en.wikipedia.org/wiki/Device_tree
;;    https://github.com/abo-abo/elf-mode

;;; Code:

(defvar-local dtb-mode nil)

(defvar dtb-mode-command "dtc -I dtb %s"
  "The shell command to use for function `dtb-mode'.")

;;;###autoload
(defun dtb-mode ()
  (interactive)
  (let ((inhibit-read-only t))
    (if dtb-mode
        (progn
          (erase-buffer)
          (insert-file-contents (buffer-file-name))
          (setq dtb-mode nil))
      (setq dtb-mode t)
      (erase-buffer)
      (insert (shell-command-to-string
               (format dtb-mode-command (buffer-file-name))))
      (goto-char (point-min)))
    (set-buffer-modified-p nil)
    (read-only-mode 1)))

;;;###autoload
(add-to-list 'magic-mode-alist '("^\320\015\376\355" . dtb-mode))

(provide 'dtb-mode)
;;; dtb-mode.el ends here
