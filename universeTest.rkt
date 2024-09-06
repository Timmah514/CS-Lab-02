;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname universeTest) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct world-state (tick shapes))

(define MTS (empty-scene 800 800))

(define-struct shape (image x y))

(define S1 (make-shape (circle 50 "solid" "red") 20 30))
(define S2 (make-shape (circle 20 "solid" "blue") 20 30))
(define S3 (make-shape (circle 40 "solid" "red") 20 30))

(define START (make-world-state 50 (list S1 S2 S3)))

(define (render state)
  (render-list (world-state-shapes state)))

(define (render-list los)
  (cond
    [(empty? los) MTS]
    [(else
     (place-image
      (shape-image (first los)))
      (shape-x (first los))
      (shape-y (first los))
      (render (rest los)))]))

(define (main state)
  (big-bang state
      (to-draw render)))