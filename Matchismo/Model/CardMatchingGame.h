//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Will Johnson on 2/6/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "CardGame.h"

@interface CardMatchingGame : CardGame
- (void)setGameplayType:(int)typeId;
@end
