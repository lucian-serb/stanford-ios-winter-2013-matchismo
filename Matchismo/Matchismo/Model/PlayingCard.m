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

@end
