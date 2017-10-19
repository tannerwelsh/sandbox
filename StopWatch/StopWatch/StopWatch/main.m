//
//  main.m
//  StopWatch
//
//  Created by Tanner Welsh on 9/7/13.
//
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
    return macruby_main("rb_main.rb", argc, argv);
}
