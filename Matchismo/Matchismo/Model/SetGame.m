//
//  SetGame.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/13/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "SetGame.h"

@interface SetGame ()

@property (strong, nonatomic) NSMutableArray *cards;
@property (readwrite, nonatomic) NSInteger score;
@property (readwrite, nonatomic) NSMutableArray *flippedCards;
@property (readwrite, nonatomic) NSInteger flipScore;
@property (readwrite, nonatomic) NSInteger gameStatus;

@end

@implementation SetGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (NSArray *)flippedCards
{
    if (!_flippedCards) {
        _flippedCards = [[NSMutableArray alloc] init];
    }
    
    return _flippedCards;
}

- (void)setGameStatus:(NSInteger)gameStatus
{
    if (gameStatus < 0) {
        _gameStatus = -1;
    } else if (gameStatus > 0) {
        _gameStatus = 1;
    } else {
        _gameStatus = 0;
    }
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
            
            [self.cards addObject:card];
        }
    }
    
    return self;
}

- (SetCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
