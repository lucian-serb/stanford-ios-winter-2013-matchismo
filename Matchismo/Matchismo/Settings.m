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
#define GAME_TYPE_KEY @"GameType"

- (void)synchronize
{
    [[NSUserDefaults standardUserDefaults] setObject:[self asPropertyList] forKey:ALL_SETTINGS_KEY];
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
            NSDictionary *settingsDict = (NSDictionary *)plist;
            _gameType = [settingsDict[GAME_TYPE_KEY] unsignedIntegerValue];
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

- (void)setGameType:(NSUInteger)gameType
{
    _gameType = gameType;
    [self synchronize];
}

+ (Settings *)allSettings
{
    NSDictionary *plist = [[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_SETTINGS_KEY];
    Settings *settings = [[Settings alloc] initFromPropertyList:plist];
    
    return settings;
}

@end
