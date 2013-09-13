//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/13/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSNumber *color in [SetCard validColors]) {
                for (NSNumber *shading in [SetCard validShading]) {
                    for (NSUInteger i = 1; i <= [SetCard maxSymbols]; i++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.color = [color unsignedIntegerValue];
                        card.shading = [shading unsignedIntegerValue];
                        card.nrSymbols = i;
                        [self addCard:card atTop:NO];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
