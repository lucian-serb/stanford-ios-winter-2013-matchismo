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

@end
