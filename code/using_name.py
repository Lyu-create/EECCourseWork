#!/usr/bin/ env python3
"""Dmonstrate the vlaue python assigns to __name __"""

def module_name():
    """Return the name Python assigned to this module"""
    return __name__

def main():
    """Report module name during direct execution"""
    print(f"This module's name is {module_name()}")

if __name__ == "__main__":
    main()