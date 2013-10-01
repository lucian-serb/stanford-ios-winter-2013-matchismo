//
//  GameResults.h
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/24/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResults : NSObject

#define ALL_CARD_RESULTS_KEY @"CardGameResults_ALL"

#define ALL_SET_RESULTS_KEY @"SetGameResults_ALL"

+ (NSArray *)allGamesResultsForKey:(NSString *)key;
+ (NSArray *)allGamesResultsSortedByDateForKey:(NSString *)key;
+ (NSArray *)allGamesResultsSortedByDurationForKey:(NSString *)key;
+ (NSArray *)allGamesResultsSortedByScoreForKey:(NSString *)key;

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *stop;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (readonly, nonatomic) NSInteger score;

- (void)setScore:(NSInteger)score forKey:(NSString *)key;

@end
