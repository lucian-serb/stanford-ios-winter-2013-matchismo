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
@property (readwrite, nonatomic) NSInteger score;
@property (readwrite, nonatomic) NSMutableArray *flippedCards;
@property (readwrite, nonatomic) NSInteger flipScore;
@property (readwrite, nonatomic) NSInteger gameStatus;
@property (nonatomic) NSUInteger noMatchingCards;

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

- (id)initWithCardCount:(NSUInteger)cardCount
        noMatchingCards:(NSUInteger)noCards
              usingDeck:(Deck *)deck
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
        
        if (noCards < 2) {
            self.noMatchingCards = 2;
        } else if (noCards > cardCount) {
            self.noMatchingCards = cardCount;
        } else {
            self.noMatchingCards = noCards;
        }
    }
    
    return self;
}

- (void)changeNoMatchingCardsTo:(NSUInteger)noCards
{
    if (noCards < 2) {
        self.noMatchingCards = 2;
    } else if (noCards > [self.cards count]) {
        self.noMatchingCards = [self.cards count];
    } else {
        self.noMatchingCards = noCards;
    }
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
            self.flipScore = 0;
            self.gameStatus = 0;
            
            for (Card *otherCard in self.cards) {
                if (!otherCard.isUnplayable && otherCard.isFaceUp) {
                    [self.flippedCards addObject:otherCard];
                    
                    if ([self.flippedCards count] == self.noMatchingCards - 1) {
                        break;
                    }
                }
            }
            
            if ([self.flippedCards count] == self.noMatchingCards - 1) {
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
            self.flipScore += FLIP_COST;
            self.score += self.flipScore;
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

@end
