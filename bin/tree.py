#!/usr/bin/env python
# -*- coding:utf-8 -*-
import argparse
'''
This is a simple script that copies from the linux util tree command.
'''

def runTree(arg):
    pass

if __name__ == '__main__':
    # defaultArg = mkDefaultArg()
    parser = argparse.ArgumentParser(description='Print the floder contents as a tree')
    parser.add_argument('-L', action='store', dest='depth', default=0, type=int, help='show floder depth')
    parser.add_argument('-D', action='store_true', dest='showFloder', default=False, help='show floder only(exclude files)')
    args = parser.parse_args()
    # print 'args: '+str(sys.argv)
    print 'depth:%s' % args.depth
    print 'show_floder:',args.showFloder
    runTree(args)