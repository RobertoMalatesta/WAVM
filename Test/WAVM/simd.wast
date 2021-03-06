;; SIMD operations

(module
  (func (export "i8x16.add_saturate_s") (param $a v128) (param $b v128) (result v128) (i8x16.add_saturate_s (get_local $a) (get_local $b)))
  (func (export "i8x16.add_saturate_u") (param $a v128) (param $b v128) (result v128) (i8x16.add_saturate_u (get_local $a) (get_local $b)))
  (func (export "i8x16.sub_saturate_s") (param $a v128) (param $b v128) (result v128) (i8x16.sub_saturate_s (get_local $a) (get_local $b)))
  (func (export "i8x16.sub_saturate_u") (param $a v128) (param $b v128) (result v128) (i8x16.sub_saturate_u (get_local $a) (get_local $b)))
  (func (export "i16x8.add_saturate_s") (param $a v128) (param $b v128) (result v128) (i16x8.add_saturate_s (get_local $a) (get_local $b)))
  (func (export "i16x8.add_saturate_u") (param $a v128) (param $b v128) (result v128) (i16x8.add_saturate_u (get_local $a) (get_local $b)))
  (func (export "i16x8.sub_saturate_s") (param $a v128) (param $b v128) (result v128) (i16x8.sub_saturate_s (get_local $a) (get_local $b)))
  (func (export "i16x8.sub_saturate_u") (param $a v128) (param $b v128) (result v128) (i16x8.sub_saturate_u (get_local $a) (get_local $b)))

  (func (export "i32x4.trunc_s/f32x4:sat") (param $a f32) (result v128) (i32x4.trunc_s/f32x4:sat (f32x4.splat (get_local $a))))
  (func (export "i32x4.trunc_u/f32x4:sat") (param $a f32) (result v128) (i32x4.trunc_u/f32x4:sat (f32x4.splat (get_local $a))))
  (func (export "i64x2.trunc_s/f64x2:sat") (param $a f64) (result v128) (i64x2.trunc_s/f64x2:sat (f64x2.splat (get_local $a))))
  (func (export "i64x2.trunc_u/f64x2:sat") (param $a f64) (result v128) (i64x2.trunc_u/f64x2:sat (f64x2.splat (get_local $a))))

  (func (export "i32.trunc_s/f32") (param $a f32) (result i32) (i32.trunc_s/f32 (get_local $a)))
  (func (export "i32.trunc_u/f32") (param $a f32) (result i32) (i32.trunc_u/f32 (get_local $a)))
  (func (export "i64.trunc_s/f32") (param $a f32) (result i64) (i64.trunc_s/f32 (get_local $a)))
  (func (export "i64.trunc_u/f32") (param $a f32) (result i64) (i64.trunc_u/f32 (get_local $a)))
  (func (export "i32.trunc_s/f64") (param $a f64) (result i32) (i32.trunc_s/f64 (get_local $a)))
  (func (export "i32.trunc_u/f64") (param $a f64) (result i32) (i32.trunc_u/f64 (get_local $a)))
  (func (export "i64.trunc_s/f64") (param $a f64) (result i64) (i64.trunc_s/f64 (get_local $a)))
  (func (export "i64.trunc_u/f64") (param $a f64) (result i64) (i64.trunc_u/f64 (get_local $a)))
)

;; i*x*.*_saturate_*

(assert_return
  (invoke "i8x16.add_saturate_s"
    (v128.const 127 126 125 124 123 122 121 120 119 120 121 122 123 124 125 126)
    (v128.const -7 -6 -5 -4 -3 -2 -1 0 +1 +2 +3 +4 +5 +6 +7 +8))
  (v128.const 120 120 120 120 120 120 120 120 120 122 124 126 127 127 127 127))

;; i32x4.trunc_s/f32x4:sat

(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const 0.0))
  (v128.const 0 0 0 0))

(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const 1.0))
  (v128.const 1 1 1 1))

(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const 1.9))
  (v128.const 1 1 1 1))

(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const 2.0))
  (v128.const 2 2 2 2))
  
(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const -1.0))
  (v128.const -1 -1 -1 -1))
  
(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const -1.9))
  (v128.const -1 -1 -1 -1))
  
(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const -2))
  (v128.const -2 -2 -2 -2))

(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const -2147483648.0))
  (v128.const -2147483648 -2147483648 -2147483648 -2147483648))

(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const -2147483648.0))
  (v128.const -2147483648 -2147483648 -2147483648 -2147483648))

(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const -3000000000.0))
  (v128.const -2147483648 -2147483648 -2147483648 -2147483648))
  
(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const -inf))
  (v128.const -2147483648 -2147483648 -2147483648 -2147483648))
  
(; not yet working correctly
(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const +inf))
  (v128.const 2147483647 2147483647 2147483647 2147483647))

(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const nan))
  (v128.const 0 0 0 0))
;)
  
;; i32x4.trunc_u/f32x4:sat

(assert_return
  (invoke "i32x4.trunc_u/f32x4:sat" (f32.const 0.0))
  (v128.const 0 0 0 0))

(assert_return
  (invoke "i32x4.trunc_u/f32x4:sat" (f32.const 1.0))
  (v128.const 1 1 1 1))

(assert_return
  (invoke "i32x4.trunc_u/f32x4:sat" (f32.const 1.9))
  (v128.const 1 1 1 1))

(assert_return
  (invoke "i32x4.trunc_u/f32x4:sat" (f32.const 2.0))
  (v128.const 2 2 2 2))
  
(assert_return
  (invoke "i32x4.trunc_u/f32x4:sat" (f32.const -1.0))
  (v128.const 0 0 0 0))

(assert_return
  (invoke "i32x4.trunc_u/f32x4:sat" (f32.const -2.0))
  (v128.const 0 0 0 0))
  
(assert_return
  (invoke "i32x4.trunc_u/f32x4:sat" (f32.const -2147483648.0))
  (v128.const 0 0 0 0))
  
(assert_return
  (invoke "i32x4.trunc_u/f32x4:sat" (f32.const -inf))
  (v128.const 0 0 0 0))
  
(; not yet working correctly
(assert_return
  (invoke "i32x4.trunc_s/f32x4:sat" (f32.const +inf))
  (v128.const 0xffffffff 0xffffffff 0xffffffff 0xffffffff))

(assert_return
  (invoke "i32x4.trunc_u/f32x4:sat" (f32.const nan))
  (v128.const 0 0 0 0))
;)
