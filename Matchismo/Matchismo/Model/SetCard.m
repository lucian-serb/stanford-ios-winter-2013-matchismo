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
    
    return validShading;
}

+ (NSArray *)validSymbols
{
    static NSArray *validSymbols;
    
    if (!validSymbols) {
        validSymbols = @[@"●", @"■", @"▲"];
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

- (NSInteger)match:(NSArray *)otherCards
{
    NSMutableArray *cards = [otherCards mutableCopy];
    [cards addObject:self];
    
    if (![self compareSymbols:cards]) {
        return 0;
    } else if (![self compareShading:cards]) {
        return 0;
    } else if (![self compareColor:cards]) {
        return 0;
    } else if (![self compareNrSymbols:cards]) {
        return 0;
    }

    return 1;
}

- (BOOL)verifyCardsArray:(NSArray *)cards
{
    if ([cards count] != 3) {
        return NO;
    }
    
    for (id card in cards) {
        if (![card isKindOfClass:[SetCard class]]) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)compareSymbols:(NSArray *)cards
{
    if (![self verifyCardsArray:cards]) {
        return NO;
    }
    
    if (([((SetCard *)cards[0]).symbol isEqualToString:((SetCard *)cards[1]).symbol]) &&
        ([((SetCard *)cards[0]).symbol isEqualToString:((SetCard *)cards[2]).symbol])) {
        return YES;
    } else if ((![((SetCard *)cards[0]).symbol isEqualToString:((SetCard *)cards[1]).symbol]) &&
               (![((SetCard *)cards[0]).symbol isEqualToString:((SetCard *)cards[2]).symbol]) &&
               (![((SetCard *)cards[1]).symbol isEqualToString:((SetCard *)cards[2]).symbol])) {
        return YES;
    }
    
    return NO;
}

- (BOOL)compareShading:(NSArray *)cards
{
    if (![self verifyCardsArray:cards]) {
        return NO;
    }
    
    if ((((SetCard *)cards[0]).shading == ((SetCard *)cards[1]).shading) &&
        (((SetCard *)cards[0]).shading == ((SetCard *)cards[2]).shading)) {
        return YES;
    } else if ((((SetCard *)cards[0]).shading != ((SetCard *)cards[1]).shading) &&
               (((SetCard *)cards[0]).shading != ((SetCard *)cards[2]).shading) &&
               (((SetCard *)cards[1]).shading == ((SetCard *)cards[2]).shading)) {
        return YES;
    }
    
    return NO;
}

- (BOOL)compareColor:(NSArray *)cards
{
    if (![self verifyCardsArray:cards]) {
        return NO;
    }
    
    if ((((SetCard *)cards[0]).color == ((SetCard *)cards[1]).color) &&
        (((SetCard *)cards[0]).color == ((SetCard *)cards[2]).color)) {
        return YES;
    } else if ((((SetCard *)cards[0]).color != ((SetCard *)cards[1]).color) &&
               (((SetCard *)cards[0]).color != ((SetCard *)cards[2]).color) &&
               (((SetCard *)cards[1]).color == ((SetCard *)cards[2]).color)) {
        return YES;
    }
    
    return NO;
}

- (BOOL)compareNrSymbols:(NSArray *)cards
{
    if (![self verifyCardsArray:cards]) {
        return NO;
    }
    
    if ((((SetCard *)cards[0]).nrSymbols == ((SetCard *)cards[1]).nrSymbols) &&
        (((SetCard *)cards[0]).nrSymbols == ((SetCard *)cards[2]).nrSymbols)) {
        return YES;
    } else if ((((SetCard *)cards[0]).nrSymbols != ((SetCard *)cards[1]).nrSymbols) &&
               (((SetCard *)cards[0]).nrSymbols != ((SetCard *)cards[2]).nrSymbols) &&
               (((SetCard *)cards[1]).nrSymbols == ((SetCard *)cards[2]).nrSymbols)) {
        return YES;
    }
    
    return NO;
}

@end
