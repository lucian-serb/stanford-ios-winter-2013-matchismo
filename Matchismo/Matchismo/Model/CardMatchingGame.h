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
              usingDeck:(Deck*)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card*)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) NSInteger score;
@property (readonly, nonatomic) NSMutableArray *flippedCards;

@end
