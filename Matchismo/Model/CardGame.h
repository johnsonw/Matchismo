//
//  CardGame.h
//  Matchismo
//
//  Created by Will Johnson on 2/6/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

typedef enum GameTypes {
    DEFAULT_MATCH_COUNT = 2,
    ADVANCED_MATCH_COUNT = 3
} GameTypes;

@interface CardGame : NSObject
// Designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck withMatchCount:(int) matchCount andMinimumMatch:(int)minimumMatch;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSString *)getStatusLabelText;
- (NSArray *) cardsMatchingContent:(NSString *)content;
- (Card *) removeCardFromDeck:(NSUInteger)index;
- (NSArray *) addCardsToDeck:(NSUInteger)numCards usingDeck:(Deck *)deck;

@property (nonatomic) int score;
@property (nonatomic) BOOL matchStatus;
@property (nonatomic) int scoreChange;
@property (strong, nonatomic) NSMutableArray *selectedCards;
@property (nonatomic) int matchCount;
@property (nonatomic) NSUInteger cardCount;
@property (strong, nonatomic) NSMutableArray *cards;
@end