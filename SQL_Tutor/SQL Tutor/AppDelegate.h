//
//  AppDelegate.h
//  SQL Tutor
//
//  Created by Tanner Welsh on 5/6/13.
//  Copyright (c) 2013 Dev Bootcamp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <FMDB/FMDatabase.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet NSTextView *resultsView;
@property (strong) FMDatabase *db;
@property (strong) FMResultSet *lastResults;
@property (weak) NSString *lastQuery;
@property int totalCount;

- (IBAction)runQuery:(id)sender;
- (IBAction)queryInput:(NSTextField *)sender;
- (void)updateInterface;

@end
