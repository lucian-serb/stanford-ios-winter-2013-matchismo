//
//  GameResults.h
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/6/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResults : NSObject

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *stop;
@property (readonly, nonatomic) NSTimeInterval *duration;
@property (nonatomic) NSInteger score;

@end