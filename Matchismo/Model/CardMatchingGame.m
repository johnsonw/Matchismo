//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Will Johnson on 2/6/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame()

@end

@implementation CardMatchingGame

/**
 Sets the gameplay type to match 2 or three cards.
 */
- (void)setGameplayType:(int)typeId
{
    if (typeId == DEFAULT_MATCH_COUNT || typeId == ADVANCED_MATCH_COUNT) {
        self.matchCount = typeId;
    }
}

@end
