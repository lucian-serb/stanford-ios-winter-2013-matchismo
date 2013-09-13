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

@end

@implementation SetGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

@end
