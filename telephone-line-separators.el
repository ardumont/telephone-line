;;; telephone-line-separators.el --- Separators for Telephone Line

;; Copyright (C) 2015 Daniel Bordak

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Separators for Telephone Line.
;; To create your own, look at the functions defined in telephone-line-utils.el
;; TODO: Trig separators

;;; Code:

(require 'memoize)
(require 'color)
(require 'telephone-line-utils)

(defcustom telephone-line-utf-8-primary-left-separator #xe0b0
    "The unicode codepoint for the left facing primary separator."
    :group 'telephone-line
    :type  '(choice integer (const nil)))

(defcustom telephone-line-utf-8-secondary-left-separator #xe0b1
    "The unicode codepoint for the left facing secondary separator."
    :group 'telephone-line
    :type  '(choice integer (const nil)))

(defcustom telephone-line-utf-8-primary-right-separator #xe0b2
    "The unicode codepoint for the right facing primary separator."
    :group 'telephone-line
    :type  '(choice integer (const nil)))

(defcustom telephone-line-utf-8-secondary-right-separator #xe0b3
    "The unicode codepoint for the right facing secondary separator."
    :group 'telephone-line
    :type  '(choice integer (const nil)))

(defun telephone-line-row-pattern-fixed-gradient (_ width)
  "Create a gradient bytestring of WIDTH from FG-COLOR to BG-COLOR."
  (mapcar (lambda (num)
            (/ num (float width)))
          (number-sequence 1 width)))

(telephone-line-defseparator telephone-line-abs-right
  #'abs #'telephone-line-row-pattern)
(telephone-line-defseparator telephone-line-abs-left
  (telephone-line-complement abs) #'telephone-line-row-pattern)
(telephone-line-defsubseparator telephone-line-abs-hollow-right
  #'abs #'telephone-line-row-pattern-hollow)
(telephone-line-defsubseparator telephone-line-abs-hollow-left
  (telephone-line-complement abs) #'telephone-line-row-pattern-hollow)
(telephone-line-defseparator telephone-line-cubed-right
  (lambda (x) (expt x 3)) #'telephone-line-row-pattern)
(telephone-line-defseparator telephone-line-cubed-left
  (lambda (x) (- (expt x 3))) #'telephone-line-row-pattern)
(telephone-line-defseparator telephone-line-cubed-hollow-right
  (lambda (x) (expt x 3)) #'telephone-line-row-pattern-hollow)
(telephone-line-defseparator telephone-line-cubed-hollow-left
  (lambda (x) (- (expt x 3))) #'telephone-line-row-pattern-hollow)
(telephone-line-defseparator telephone-line-gradient
  #'identity #'telephone-line-row-pattern-fixed-gradient)
(telephone-line-defseparator telephone-line-identity-right
  #'identity #'telephone-line-row-pattern)
(telephone-line-defseparator telephone-line-identity-left
  #'- #'telephone-line-row-pattern)
(defmemoize telephone-line-nil (color1 color2)
  nil)

(defmemoize telephone-line-utf-8-filled-left (foreground background)
  (propertize (char-to-string telephone-line-utf-8-primary-left-separator)
              'face `(:foreground ,foreground :background ,background)))

(defmemoize telephone-line-utf-8-filled-right (background foreground) ;Note the reversed params
  (propertize (char-to-string telephone-line-utf-8-primary-right-separator)
              'face `(:foreground ,foreground :background ,background)))

(defmemoize telephone-line-utf-8-left (foreground background)
  (propertize (concat " " (char-to-string telephone-line-utf-8-secondary-left-separator) " ")
              'face `(:foreground ,foreground :background ,background)))

(defmemoize telephone-line-utf-8-right (foreground background)
  (propertize (concat " " (char-to-string telephone-line-utf-8-secondary-right-separator) " ")
              'face `(:foreground ,foreground :background ,background)))

(provide 'telephone-line-separators)
;;; telephone-line-separators.el ends here
