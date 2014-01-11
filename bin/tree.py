#!/usr/bin/env python
# -*- coding:utf-8 -*-
import argparse
import sys
import os
'''
This is a simple copy of the tree command.
'''

__author__ = 'Fity'
__email__ = 'imfity@gmail.com'
__copyright__ = '(c) 2014 %s' % __author__
__license__ = 'BSD'

__version__ = '0.1'


def show_name(item, depth, isDir=False, colored=False):
    if isDir:
        item = item+os.path.sep
    if colored:
        pass
    print '|  '*(depth-1)+'|--'+item
    return

def tree_sort(dlist, args):
    return dlist

def display_tree(dest, args, depth=1):
    if depth > args.depth:
        return
    dlist = os.listdir(dest)
    dlist = tree_sort(dlist, args)
    for item in dlist:
        dir = os.path.join(dest, item)
        if os.path.isfile(dir):
            if args.show_floder:
                pass
            else:
                show_name(item, depth)
        elif os.path.isdir(dir):
            # is dir
            show_name(item, depth, isDir=True, colored=args.show_color)
            display_tree(dir, args, depth+1)
    return

def runTree():
    curDir = os.getcwd()

    parser = argparse.ArgumentParser(prog='tree', description='Print the floder contents as a tree')
    parser.add_argument('-L', action='store', dest='depth', default=sys.maxint, type=int, help='show floder depth')
    parser.add_argument('-d', action='store_true', dest='show_floder', default=False, help='show floder only(exclude files)')
    parser.add_argument('dest', action='store', default=curDir, help='dest floder to show',nargs='?')
    parser.add_argument('-C', action='store_true', dest='show_color', default=False, help='show different colors for floders and files(not supported yet)')
    args = parser.parse_args()
    dest = args.dest
    if not os.path.isdir(dest):
        print 'error: dest should be a dir'
        return
    if not os.path.exists(dest):
        print 'error: dest "%s" not exists' % dest
    print dest
    display_tree(dest, args)
    return

if __name__ == '__main__':
    runTree()
