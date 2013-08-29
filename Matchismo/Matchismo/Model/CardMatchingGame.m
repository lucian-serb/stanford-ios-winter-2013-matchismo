//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 8/29/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic) NSMutableArray *cards;
@property (nonatomic) NSInteger score;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }

    return _cards;
}

- (id)init
{
    return nil;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (NSUInteger i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            
            if (!card) {
                return nil;
            }
            
            self.cards[i] = card;
        }
    }
    
    return self;
}

- (Card*)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
