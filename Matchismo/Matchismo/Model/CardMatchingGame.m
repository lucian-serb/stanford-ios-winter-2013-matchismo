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
@property (readwrite, nonatomic) NSMutableArray *flippedCards;
@property (readwrite, nonatomic) NSInteger flipScore;
@property (readwrite, nonatomic) NSInteger gameStatus;

@end

@implementation CardMatchingGame

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

- (NSArray *)flippedCards
{
    if (!_flippedCards) {
        _flippedCards = [[NSMutableArray alloc] init];
    }
    
    return _flippedCards;
}

#define FLIP_COST -1
#define MISMATCH_PENALTY -2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            [self.flippedCards removeAllObjects];
            [self.flippedCards addObject:card];
            self.flipScore = 0;
            self.gameStatus = 0;
            
            for (Card *otherCard in self.cards) {
                if (!otherCard.isUnplayable && otherCard.isFaceUp) {
                    [self.flippedCards addObject:otherCard];
                    NSInteger matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.flipScore = matchScore * MATCH_BONUS;
                        self.gameStatus = 1;
                    } else {
                        otherCard.faceUp = NO;
                        self.flipScore = MISMATCH_PENALTY;
                        self.gameStatus = -1;
                    }

                    break;
                }
            }
            
            self.flipScore += FLIP_COST;
            self.score += self.flipScore;
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

@end
