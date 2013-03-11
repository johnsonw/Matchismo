//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Will Johnson on 2/4/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"

@interface CardGameViewController () 
@end

@implementation CardGameViewController

- (Deck *)createDeck
{
    self.deck = [[PlayingCardDeck alloc] init];
    return self.deck;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.isFaceUp;
            playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}

- (NSUInteger) startingCardCount
{
    return STARTING_COUNT;
}

- (int) matchCount
{
    return MATCH_COUNT;
}

- (int) minimumMatch
{
    return MINIMUM_MATCH;
}

- (void) analyzeCardOnUpdate:(Card *)card viewsToRemove:(NSMutableArray *)viewsToRemove indexPath:(NSIndexPath *)indexPath cell:(UICollectionViewCell *)cell
{
    [self updateCell:cell usingCard:card];
}

- (NSString *) collectionViewIdentifier
{
    return @"PlayingCard";
}

- (void) updateStatusLabel
{
    self.statusLabel.text = [self.game getStatusLabelText];
}

@end
