//
//  PlayingCard.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 8/22/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *)validSuites
{
    static NSArray *validSuites;
    
    if (!validSuites) {
        validSuites = @[@"♥", @"♦", @"♠", @"♣"];
    }
    
    return validSuites;
}

+ (NSArray *)rankStrings
{
    static NSArray *rankStrings;
    
    if (!rankStrings) {
        rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    }
    
    return rankStrings;
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

@end
