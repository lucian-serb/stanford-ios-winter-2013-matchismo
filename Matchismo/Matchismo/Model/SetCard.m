//
//  SetCard.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/12/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSUInteger)maxSymbols
{
    return [[self validSymbols] count];
}

+ (NSArray *)validColors
{
    static NSArray *validColors;
    
    if (!validColors) {
        validColors = @[@(GREEN), @(RED), @(PURPLE)];
    }
    
    return validColors;
}

+ (NSArray *)validShading
{
    static NSArray *validShading;
    
    if (!validShading) {
        validShading = @[@(SOLID), @(STRIPED), @(OPEN)];
    }
    
    return nil;
}

+ (NSArray *)validSymbols
{
    static NSArray *validSymbols;
    
    if (!validSymbols) {
        validSymbols = @[@"◯", @"▢", @"△"];
    }
    
    return validSymbols;
}

@end
