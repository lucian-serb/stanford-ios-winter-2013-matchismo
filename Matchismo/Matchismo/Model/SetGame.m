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

#define MISMATCH_PENALTY -2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            [self.flippedCards removeAllObjects];
            self.flipScore = 0;
            self.gameStatus = 0;
            
            for (Card *otherCard in self.cards) {
                if (!otherCard.isUnplayable && otherCard.isFaceUp) {
                    [self.flippedCards addObject:otherCard];
                    
                    if ([self.flippedCards count] == MATCHING_CARDS - 1) {
                        break;
                    }
                }
            }
            
            if ([self.flippedCards count] == MATCHING_CARDS - 1) {
                NSInteger matchScore = [card match:self.flippedCards];
                
                if (matchScore) {
                    for (Card *otherCard in self.flippedCards) {
                        otherCard.unplayable = YES;
                    }
                    
                    card.unplayable = YES;
                    self.flipScore = matchScore * MATCH_BONUS;
                    self.gameStatus = 1;
                } else {
                    for (Card *otherCard in self.flippedCards) {
                        otherCard.faceUp = NO;
                    }
                    
                    self.flipScore = MISMATCH_PENALTY;
                    self.gameStatus = -1;
                }
            }
            
            [self.flippedCards addObject:card];
            self.score += self.flipScore;
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

@end
