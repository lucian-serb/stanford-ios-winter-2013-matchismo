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

+ (NSArray *)allGamesResults
{
    NSMutableArray *allResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResults *results = [[GameResults alloc] initFromPropertyList:plist];
        [allResults addObject:results];
    }
    
    return allResults;
}

- (NSComparisonResult)compareDate:(GameResults *)gameResults
{
    return [self.start compare:gameResults.start];
}

- (NSComparisonResult)compareDuration:(GameResults *)gameResults
{
    if (self.duration < gameResults.duration) {
        return NSOrderedAscending;
    } else if (self.duration > gameResults.duration) {
        return NSOrderedDescending;
    }
    
    return NSOrderedSame;
}

- (NSComparisonResult)compareScore:(GameResults *)gameResults
{
    if (self.score < gameResults.score) {
        return NSOrderedAscending;
    } else if (self.score > gameResults.score) {
        return NSOrderedDescending;
    }
    
    return NSOrderedSame;
}

+ (NSArray *)allGamesResultsSortedByDate
{
    return [[self allGamesResults] sortedArrayUsingSelector:@selector(compareDate:)];
}

+ (NSArray *)allGamesResultsSortedByDuration
{
    return [[self allGamesResults] sortedArrayUsingSelector:@selector(compareDuration:)];
}

+ (NSArray *)allGamesResultsSortedByScore
{
    return [[self allGamesResults] sortedArrayUsingSelector:@selector(compareScore:)];
}

- (id)initFromPropertyList:(id)plist
{
    self = [self init];
    
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultsDict = (NSDictionary *)plist;
            _start = resultsDict[START_KEY];
            _stop = resultsDict[STOP_KEY];
            _score = [resultsDict[SCORE_KEY] integerValue];
            
            if (!_start || !_stop) {
                return nil;
            }
            
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
    [self synchronize];
}

@end
