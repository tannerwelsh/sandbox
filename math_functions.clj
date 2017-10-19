(defn factorial [n]
  (if (= n 0)
    1
    (* n (factorial (- n 1)))))

(defn fibonacci [n]
  (if (= n 1)
    0
    (if (= n 2)
      1
      (+ (fibonacci (- n 2)) (fibonacci (- n 1))))))

(printf "%s\n" (fibonacci 30))
(printf "%s\n" (factorial 10))

