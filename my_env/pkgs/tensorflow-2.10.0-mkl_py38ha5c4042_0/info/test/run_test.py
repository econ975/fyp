#  tests for tensorflow-2.10.0-mkl_py38ha5c4042_0 (this is a generated file);
print('===== testing package: tensorflow-2.10.0-mkl_py38ha5c4042_0 =====');
print('running run_test.py');
#  --- run_test.py (begin) ---
import tensorflow as tf
hello = tf.constant('Hello, TensorFlow!')
a = tf.constant(10)
b = tf.constant(32)
tf.debugging.assert_equal(a+b, 42)
print(a+b)
print("a+b={}".format(a+b))
print("Test finished")#  --- run_test.py (end) ---

print('===== tensorflow-2.10.0-mkl_py38ha5c4042_0 OK =====');
