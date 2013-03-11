//
//  GameViewController.h
//  Matchismo
//
//  Created by Will Johnson on 2/24/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "CardMatchingGame.h"
#import "Deck.h"

@interface GameViewController : UIViewController
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) NSUInteger startingCardCount; // abstract
@property (strong, nonatomic) NSString *collectionViewIdentifier; // abstract
@property (nonatomic) int matchCount; // abstract
@property (nonatomic) int minimumMatch; // abstract
@property (nonatomic) Deck *deck; // abstract
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (void)updateUI;
- (IBAction)dealGame:(UIButton *)sender;
- (Deck *)createDeck; // abstract;
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card;
- (void) setButtonStates:(UIButton *)cardButton :(Card *)card;
- (void) updateStatusLabel;
- (void) analyzeCardOnUpdate:(Card *)card viewsToRemove:(NSMutableArray *)viewsToRemove indexPath:(NSIndexPath *)indexPath cell:(UICollectionViewCell *)cell;
@end
