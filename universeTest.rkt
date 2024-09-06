;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname universeTest) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;Contains the current tick of the world and a list of the currently available shapes
(define-struct world-state (tick shapes))

(define MTS (empty-scene 800 800))

;conatins an image, coordinates and speed of a shape
(define-struct shape (image x y speedx speedy))

(define S1 (make-shape (circle 50 "solid" "red") 20 30 1 1))
(define S2 (make-shape (circle 20 "solid" "blue") 200 700 1 -1))
(define S3 (make-shape (circle 40 "solid" "green") 750 70 -1 1))

(define START (make-world-state 50 (list S1 S2 S3)))

;places each shape onto the mts by calling itself recursively - helper function to render
(define (render-list los)
  (cond
    [(empty? los) MTS]
    [else
     (place-image
      (shape-image (first los))
      (shape-x (first los))
      (shape-y (first los))
      (render-list (rest los)))]))

;calls the render-list helper function to draw everything to the screen
(define (render state)
   (render-list (world-state-shapes state)))

;moves the shapes according to their speed
(define (move-shapes los)
  (set! (shape-x (first los)) (+ (shape-x (first los)) (shape-speedx (first los)))))

;the main function
(define (main state)
  (big-bang state
    (on-tick (move-shapes (world-state-shapes state)))
    (to-draw render)))

(main START)