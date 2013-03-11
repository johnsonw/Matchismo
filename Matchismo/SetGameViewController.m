//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Will Johnson on 2/4/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "Card.h"
#import "CardMatchingGame.h"
#import "GameViewController.h"
#import "SetCollectionViewCell.h"
#import "SetGameStatusView.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Deck *)createDeck
{
    self.deck = [[SetCardDeck alloc] init];
    return self.deck;
}

- (NSUInteger) startingCardCount
{
    return STARTING_CARD_COUNT;
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
    if ([card isUnplayable]) {
        [viewsToRemove addObject:indexPath];
        // Remove the card from the model BEFORE removing it from the collection view
        [self.game removeCardFromDeck:indexPath.item];
    } else {
        [self updateCell:cell usingCard:card];
    }
}


- (NSString *) collectionViewIdentifier
{
    return @"SetCard";
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[SetCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetCollectionViewCell *)cell).setCardView;
        
        if ([card isKindOfClass:[SetCard class]]) {
            
            SetCard *setCard = (SetCard *)card;
            setCardView.shape = setCard.shape;
            setCardView.shapeCount = setCard.shapeCount;
            setCardView.shapeType = setCard.shapeType;
            setCardView.color = setCard.color;
            setCardView.faceUp = setCard.faceUp;
            setCardView.alpha = setCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}

- (void) updateStatusLabel
{
    SetGameStatusView *view = nil;
    NSArray *subviews = [self.view subviews];
    for (UIView *subview in subviews) {
        if ([subview isKindOfClass:[SetGameStatusView class]]) {
            view = (SetGameStatusView *)subview;
            break;
        }
    }

    if (view) {
        view.selectedCards = [self.game selectedCards];
        view.matchStatus = self.game.matchStatus;
        [view updateStatus];
    }
    
    // Updte the score change
    if (self.game.scoreChange > 0 || self.game.scoreChange < 0) {
        self.statusLabel.text = [NSString stringWithFormat:@"Score Changed By: %d", self.game.scoreChange];
    } else {
        self.statusLabel.text = [NSString stringWithFormat:@""];
    }
}

- (IBAction)addThreeCards:(UIButton *)sender {
    // Request that three cards be added to the current list of cards from the deck.
    NSArray *addedCards = [self.game addCardsToDeck:3 usingDeck:self.deck];
    NSMutableArray *indexes = [[NSMutableArray alloc] init];
    int addedCardsCount = [addedCards count];
    int count = [self.game cardCount] - addedCardsCount;
    
    for (int i = count; i < count + addedCardsCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [indexes addObject:indexPath];
    }

    if ([indexes count] > 0) {
        [self.cardCollectionView insertItemsAtIndexPaths:indexes];
        [self.cardCollectionView selectItemAtIndexPath:indexes[[indexes count] - 1] animated:true scrollPosition:UICollectionViewScrollPositionBottom];
    } else {
        // Notify the user that there are no more cards to add
        self.statusLabel.text = @"No more cards to add.";
    }
}

@end
