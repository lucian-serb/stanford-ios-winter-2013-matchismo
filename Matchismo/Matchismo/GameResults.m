//
//  GameResults.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/6/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "GameResults.h"

@interface GameResults ()

@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *stop;

@end

@implementation GameResults

#define ALL_RESULTS_KEY @"GameResults_ALL"

- (void)synchronize
{
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey: ALL_RESULTS_KEY] mutableCopy];
    
    if (!mutableGameResultsFromUserDefaults) {
        mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    }
    
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

#define START_KEY @"StartDate"
#define STOP_KEY @"StopDate"
#define SCORE_KEY @"Score"

- (id)asPropertyList
{
    return @{START_KEY: self.start, STOP_KEY: self.stop, SCORE_KEY: @(self.score)};
}

- (id)init
{
    self = [super init];
    
    if (self) {
        _start = [NSDate date];
        _stop = _start;
    }
    
    return self;
}

- (NSTimeInterval )duration
{
    return [self.stop timeIntervalSinceDate:self.start];
}

- (void)setScore:(NSInteger)score
{
    _score = score;
    self.stop = [NSDate date];
}

@end
