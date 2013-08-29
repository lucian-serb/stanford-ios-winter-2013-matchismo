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

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (!otherCard.isUnplayable && otherCard.isFaceUp) {
                    NSInteger matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    
                    break;
                }
            }
            
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

@end
