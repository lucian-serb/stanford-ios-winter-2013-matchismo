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

- (void)setNrSymbols:(NSUInteger)nrSymbols
{
    if ((nrSymbols > 0) && (nrSymbols <= [SetCard maxSymbols])) {
        _nrSymbols = nrSymbols;
    }
}

- (void)setColor:(COLOR_T)color
{
    if (color < COLOR_SIZE) {
        _color = color;
    }
}

- (void)setShading:(SHADING_T)shading
{
    if (shading < SHADING_SIZE) {
        _shading = shading;
    }
}

@synthesize symbol = _symbol;

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)contents
{
    NSString *contents = @"";
    
    for (NSUInteger i = 0; i < self.nrSymbols; i++) {
        contents = [contents stringByAppendingString:self.symbol];
    }
    
    return contents;
}

@end
