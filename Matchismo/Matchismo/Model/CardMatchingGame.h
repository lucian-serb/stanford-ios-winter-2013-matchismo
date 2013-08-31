//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 8/29/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
        noMatchingCards:(NSUInteger)noCards
              usingDeck:(Deck*)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card*)cardAtIndex:(NSUInteger)index;

- (void)changeNoMatchingCardsTo:(NSUInteger)noCards;

@property (readonly, nonatomic) NSInteger score;
@property (readonly, nonatomic) NSMutableArray *flippedCards;
@property (readonly, nonatomic) NSInteger flipScore;
@property (readonly, nonatomic) NSInteger gameStatus;

@end
