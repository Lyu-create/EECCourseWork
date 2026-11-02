def buggyfunc(x):
    y = x
    for i in range(x):
        try:
            y = y - 1 # only y decreases
            z = x/y # x is still the value given to the function
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work;{x = };{y = }")
        else:
            print(f"Ok; {x = }; {y = }, {z = };")
    return z

buggyfunc(20)

# run ipython from project root: %run code/debugme.py
# automatic debugging: %pdb for both turning on and off
# ipdb> p x (print value x) / l print the code surrounding the current position/ q quit
# %cpaste copy and paste code, execute on new line ctrl + D