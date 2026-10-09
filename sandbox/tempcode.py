x = 11
for i in range(x):
    if i > 3: #4 spaces or 2 tabs in this case
        print(i)

for i in range (10):
    print (i)

for i in range (1, 6):
    print (i)

for i in range (2, 10, 2):
    print (i)

my_iterable = [1,2,3]
type(my_iterable)

my_iterator = iter(my_iterable)
type (my_iterator)
next (my_iterator)
next (my_iterator)
next (my_iterator)
next (my_iterator)

heights = [8, 12, 10]
height_iterator = iter(heights)
print(next(height_iterator))
print(list(height_iterator))
print(list(height_iterator))
print(heights)

height_generator = (height_cm * 2 for height_cm in heights)
print(next(height_generator))
print(list(height_generator))
print(list(height_generator))

height_range = range (3)
print(list(height_range))
print(list(height_range))

# if <expr>:
#   <statement>

x = 0; y = 2
if x < y: # "Truthy"
    print ('yes')

if x: 
    print('yes')

if x == 0:
    print('yes')

if y:
    print ('yes')

if y == 2:
    print ('yes')

x = True # make x boolean

if x: # now it works
    print('yes')

if x == True:
    print('yes')

def foo(x):
    x *= x # same as x = x*x
    print(x)

%whos

foo(2)

def foo(x):
    x *= x # same as x = x*x
    print(x)
    return x

y = foo(2)
y
type (y)

def modify_list_1(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)

my_list = [1, 2, 3]
print('before, my_list =', my_list)

modify_list_1(my_list)

print('after, my_list =', my_list)

def modify_list_2(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)
    return some_list

my_list = modify_list_2(my_list)

print('after, my_list =', my_list)

def modify_list_3(some_list):
    print('got', some_list)
    some_list.append(4)
    print('change to', some_list)

my_list = [1, 2, 3]

print('before, my_list =', my_list)

modify_list_3(my_list)

print('after, my_list =', my_list)

heights_cm = [8, 12, 10, 15]
above_threshold = 0
for height_cm in heights_cm:
    if height_cm >= 10:
        above_threshold += 1
print(above_threshold)

def count_above(heights_cm, threshold_cm):
    above_threshold = 0
    for height_cm in heights_cm:
        if height_cm > threshold_cm:
            above_threshold += 1
    return above_threshold

assert count_above([8, 12, 10, 15], 10) == 2
assert count_above([10], 10) == 0
# testing the threshold values to make sure the logic is correct
# an empty list would lead to AssertionError, 
# no for block runs, 
# goes directly to above_threshold 0
assert count_above([], 10) == 0

load_observations("data/bootcamp_observations.csv")

def require_non_negative(number):
    if number<0:
        raise ValueError("Count must be non-negative")
    return number
assert require_non_negative(2) == 2

try:
    require_non_negative(-1)
except ValueError:
    print("Expected ValueError caught")
else:
    raise AssertionError("A negative count was accepted")