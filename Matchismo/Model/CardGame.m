//
//  CardGame.m
//  Matchismo
//
//  Created by Will Johnson on 2/6/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardGame.h"
#import "Card.h"
#import "SetCard.h"

@interface CardGame()
@property (nonatomic) int minimumMatch;
@end

@implementation CardGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

/**
 * Holds the array of cards. Lazy instantiated.
 */
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger) cardCount
{
    return [self.cards count];
}

/**
 * An array that keeps track of the selected cards. It's lazy instantiated.
 */
- (NSMutableArray *) selectedCards
{
    if (!_selectedCards) _selectedCards = [[NSMutableArray alloc] init];
    return _selectedCards;
}

/**
 * Removes the specified card from the deck of cards.
 */
- (Card *) removeCardFromDeck:(NSUInteger)index
{
    Card *card = nil;
    if ([self.cards count] > index) {
        card = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return card;
}

- (NSArray *) addCardsToDeck:(NSUInteger)numCards usingDeck:(Deck *)deck
{
    NSMutableArray *cardsToBeAdded = [[NSMutableArray alloc] init];
    for (int i = 0; i < numCards; i++) {
        Card *card = [deck drawRandomCard];
        if (card) {
            [cardsToBeAdded addObject:card];
            [self.cards addObject:card];
        }
    }
    
    return [cardsToBeAdded copy];
}

/**
 * Returns an NSArray of cards matching the specified content
 */
- (NSArray *) cardsMatchingContent:(NSString *)content
{
    NSMutableArray *matchingCards = [[NSMutableArray alloc] init];
    for (Card *currentCard in self.selectedCards) {
        if ([currentCard.contents isEqualToString:content]) {
            [matchingCards addObject:currentCard];
        }
    }
    
    return [matchingCards copy];
}

// Designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck withMatchCount:(int) matchCount andMinimumMatch:(int)minimumMatch
{
    NSLog(@"initializing game with card count: %d", cardCount);
    //NSObject's designated initializer is init
    self = [super init];
    
    if (self) {
        self.cards = nil;
        self.score = 0;
        self.matchStatus = false;
        self.scoreChange = 0;
        self.matchCount = matchCount;
        self.selectedCards = nil;
        self.minimumMatch = minimumMatch;
        
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

/**
 * Retrieves the card at the specified index.
 */
- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

/**
 * This method will flip the card at the specified index. If the card is being flipped up and
 * the number of other flipped cards is equal the match count - 1 then we will check to see if a
 * match is made and handle that case accordingly. After checking this, it will set the selectedCards
 * array to all flipped cards (including the card that is being flipped up. A cost will also be
 * deducted from your score for flipping. Finally, the status of the card will be toggled.
 */
- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            // The current card is still face down until we tell it to flip over. Let's get a list of all
            // other cards that are face up.
            NSMutableArray *flippedCards = [self getCardsFacingUp];
            if (flippedCards.count == self.matchCount - 1) {
                [self checkForMatchWith:card andFlippedCards:flippedCards];
            }
            [self.selectedCards removeAllObjects];
            [self.selectedCards addObject:card];
            [self.selectedCards addObjectsFromArray:flippedCards];
            
            self.score -= FLIP_COST;
        }
        
        // Udate the state of the card. We could be turning it face up or face over.
        card.faceUp = !card.isFaceUp;
    }
}

/**
 * Checks to see if the card and array of flipped cards match. If they do, it disables the
 * matched cards, sets the value of the change in score, and sets the matchStatus to true. Otherwise,
 * it will turn the other cards over, penalize the score, and set the match status to false. The
 * score will be updated based on the value of the score change.
 */
- (void) checkForMatchWith:(Card *)card andFlippedCards:(NSMutableArray *)flippedCards
{
    int matchScore = [card match:flippedCards];
    if (matchScore >= self.minimumMatch) {
        for (Card *otherCard in flippedCards) {
            otherCard.unplayable = YES;
        }
        
        card.unplayable = YES;
        self.scoreChange = matchScore * MATCH_BONUS;
        self.matchStatus = true;
    } else {
        for (Card *otherCard in flippedCards) {
            otherCard.faceUp = NO;
        }
        self.scoreChange = -MISMATCH_PENALTY;
        self.matchStatus = false;
    }
    
    self.score += self.scoreChange;
}

/**
 * Retrieves and array of cards that are facing up.
 */
- (NSMutableArray *)getCardsFacingUp
{
    // Create an array that has all cards that are face up
    NSMutableArray *flippedCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards) {
        if (otherCard.isFaceUp && !otherCard.isUnplayable) {
            [flippedCards addObject:otherCard];
        }
    }
    
    return flippedCards;
}

/**
 * Generates status text
 */
- (NSString *)getStatusLabelText
{
    NSString *statusLabel = @"";
    NSString *contentString = [self.selectedCards componentsJoinedByString:@" & "];
    
    if (self.selectedCards.count < self.matchCount) {
        statusLabel = @"";
    } else if (self.matchStatus) {
        statusLabel = [NSString stringWithFormat:@"Matched %@ for %d points", contentString, self.scoreChange];
        
    } else if (!self.matchStatus) {
        statusLabel = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", contentString, self.scoreChange];
    }
    
    return statusLabel;
}

@end
