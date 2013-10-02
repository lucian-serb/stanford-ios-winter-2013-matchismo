//
//  Settings.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 10/2/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "Settings.h"

@implementation Settings

#define ALL_SETTINGS_KEY @"Settings_ALL"
#define GENERAL_SETTINGS @"Settings_GENERAL"
#define GAME_TYPE_KEY @"GameType"

- (void)synchronize
{
    NSMutableDictionary *mutableSettingsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey: ALL_SETTINGS_KEY] mutableCopy];
    
    if (!mutableSettingsFromUserDefaults) {
        mutableSettingsFromUserDefaults = [[NSMutableDictionary alloc] init];
    }
    
    mutableSettingsFromUserDefaults[GENERAL_SETTINGS] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableSettingsFromUserDefaults forKey:ALL_SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (id)asPropertyList
{
    return @{GAME_TYPE_KEY: @(self.gameType)};
}

- (id)initFromPropertyList:(id)plist
{
    self = [self init];
    
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultsDict = (NSDictionary *)plist;
            _gameType = [resultsDict[GAME_TYPE_KEY] unsignedIntegerValue];
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
