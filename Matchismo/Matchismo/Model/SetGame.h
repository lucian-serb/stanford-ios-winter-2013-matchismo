//
//  SetGame.h
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/13/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "SetCard.h"

@interface SetGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (SetCard *)cardAtIndex:(NSUInteger)index;

@end
