//
//  PlayingCard.m
//  Matchismo
//
//  Created by Will Johnson on 2/5/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (NSString *)description
{
    return [self contents];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits) validSuits = @[@"♥",@"♦",@"♠",@"♣"];
    return validSuits;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (int)match:(NSArray *)otherCards
{
    int score1 = 0;
    int score2 = 0;

    for (id otherCard in otherCards) {
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *curCard = (PlayingCard *)otherCard;
            if ([curCard.suit isEqualToString:self.suit]) {
                score1 += 1;
            } else {
                score1 = 0;
                break;
            }
        }
    }
    
    for (id otherCard in otherCards) {
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *curCard = (PlayingCard *)otherCard;
            if (curCard.rank == self.rank) {
                score2 += 4;
            } else {
                score2 = 0;
                break;
            }
        }
    }
    
    return score1 + score2;
}

+ (NSArray *)rankStrings
{
    static NSArray *rankStrings = nil;
    if (!rankStrings) rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return rankStrings;
}

+ (NSUInteger)maxRank { return [self rankStrings].count - 1; }
@end
