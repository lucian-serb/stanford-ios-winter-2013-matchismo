//
//  Settings.h
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 10/2/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

+ (Settings *)allSettings;

@property (nonatomic) NSUInteger gameType;

@end
