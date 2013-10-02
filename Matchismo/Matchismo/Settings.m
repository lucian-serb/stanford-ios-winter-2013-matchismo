//
//  Settings.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 10/2/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "Settings.h"

@implementation Settings

#define GAMETYPE_KEY @"GameType"

- (id)initFromPropertyList:(id)plist
{
    self = [self init];
    
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultsDict = (NSDictionary *)plist;
            _gameType = [resultsDict[GAMETYPE_KEY] unsignedIntegerValue];
        } else {
            return nil;
        }
    }
    
    return self;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        _gameType = 0;
    }
    
    return self;
}

@end
