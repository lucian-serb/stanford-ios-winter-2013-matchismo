//
//  SetCard.h
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/12/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

typedef enum {GREEN, RED, PURPLE} COLOR_T;
typedef enum {SOLID, STRIPED, OPEN} SHADING_T;

@property (nonatomic) NSUInteger nrSymbols;
@property (nonatomic) COLOR_T color;
@property (nonatomic) SHADING_T shading;
@property (strong, nonatomic) NSString *symbol;

+ (NSUInteger)maxSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validShading;
+ (NSArray *)validSymbols;

@end