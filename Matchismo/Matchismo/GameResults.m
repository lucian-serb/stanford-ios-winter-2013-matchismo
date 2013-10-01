//
//  GameResults.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/24/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "GameResults.h"

@interface GameResults ()

@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *stop;
@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) NSString *gameType;

@end

@implementation GameResults

- (void)synchronize
{
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey: self.gameType] mutableCopy];
    
    if (!mutableGameResultsFromUserDefaults) {
        mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    }
    
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:self.gameType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

#define START_KEY @"StartDate"
#define STOP_KEY @"StopDate"
#define SCORE_KEY @"Score"

- (id)asPropertyList
{
    return @{START_KEY: self.start, STOP_KEY: self.stop, SCORE_KEY: @(self.score)};
}

+ (NSArray *)allGamesResultsForKey:(NSString *)key
{
    NSMutableArray *allResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:key] allValues]) {
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

+ (NSArray *)allGamesResultsSortedByDateForKey:(NSString *)key
{
    return [[self allGamesResultsForKey:key] sortedArrayUsingSelector:@selector(compareDate:)];
}

+ (NSArray *)allGamesResultsSortedByDurationForKey:(NSString *)key
{
    return [[self allGamesResultsForKey:key] sortedArrayUsingSelector:@selector(compareDuration:)];
}

+ (NSArray *)allGamesResultsSortedByScoreForKey:(NSString *)key
{
    return [[self allGamesResultsForKey:key] sortedArrayUsingSelector:@selector(compareScore:)];
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

- (NSString *)gameType
{
    if (!_gameType) {
        _gameType = ALL_CARD_RESULTS_KEY;
    }
    
    return _gameType;
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

- (void)setScore:(NSInteger)score forKey:(NSString *)key
{
    self.gameType = key;
    self.score = score;
}

@end
