//
//  AppDelegate.m
//  SQL Tutor
//
//  Created by Tanner Welsh on 5/6/13.
//  Copyright (c) 2013 Dev Bootcamp. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    FMDatabase *newDB = [FMDatabase databaseWithPath:@"/Users/tannerwelsh/Dev/sandbox/SQL Tutor/SQL Tutor/sqltutor.sqlite3"];
    [self setDb:newDB];

}

- (IBAction)runQuery:(id)sender
{
    [self.db open];
    
    NSString *query = self.lastQuery;
    self.lastResults = [self.db executeQuery:query];
    
    int total;
    
    while ([self.lastResults next])
    {
        total = [self.lastResults intForColumnIndex:0];
    }
    
    [self setTotalCount:total];
    [self updateInterface];
    
    [self.db close];
}

- (IBAction)queryInput:(NSTextField *)sender
{
    NSString *queryString = [sender stringValue];
    [self setLastQuery:queryString];
}


- (void)updateInterface
{
    NSString *results = [NSString stringWithFormat:@"Count: %d", self.totalCount];
    [self.resultsView insertText:results];
}

@end
