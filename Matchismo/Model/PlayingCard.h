//
//  PlayingCard.h
//  Matchismo
//
//  Created by Will Johnson on 2/5/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
