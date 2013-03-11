//
//  SetGameView.m
//  Matchismo
//
//  Created by Will Johnson on 3/6/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetGameStatusView.h"
#import "SetCard.h"

#define MATCH_COUNT 3
#define DIAMOND_WIDTH 20
#define OVAL_WIDTH 10
#define SQUIGGLE_WIDTH 20
#define PADDING 5

@interface SetGameStatusView()
- (void)drawCard:(SetCard *)card;
- (void)drawShapes;
- (void)displaySelectedCards:(NSAttributedString *)appender;

@property (nonatomic) float posX;
@end

@implementation SetGameStatusView

- (void) drawRect:(CGRect)rect
{
    NSAttributedString *appender = [[NSAttributedString alloc] initWithString:@"&"];
    if (self.matchStatus && self.selectedCards.count == 3) {
        NSAttributedString *statusLabel = [[NSAttributedString alloc] initWithString:@"Matched "];
        [statusLabel drawAtPoint:CGPointMake(0, 3)];
        self.posX = [statusLabel size].width;
        [self displaySelectedCards:appender];
    } else if (!self.matchStatus && self.selectedCards.count == 3) {
        self.posX = 5;
        
        [self displaySelectedCards:appender];
        
        NSAttributedString *statusLabel = [[NSAttributedString alloc] initWithString:@"Do Not Match!"];
        [statusLabel drawAtPoint:CGPointMake(self.posX, 3)];
    } else if (self.selectedCards.count > 0){
        // Just show which cards are currently selected
        self.posX = 5;
        
        [self displaySelectedCards:appender];
        
        NSAttributedString *statusLabel = [[NSAttributedString alloc] initWithString:@"Selected."];
        [statusLabel drawAtPoint:CGPointMake(self.posX, 3)];
    }
}

- (void) displaySelectedCards:(NSAttributedString *)appender
{
    for (SetCard *card in self.selectedCards) {
        [self drawCard:card];
        
        // If this is not the last object then draw the appender
        if (card != [self.selectedCards lastObject]) {
            [appender drawAtPoint:CGPointMake(self.posX, 3)];
            // Add the padding
            self.posX += [appender size].width + PADDING;
        }
    }
}

- (void) setSelectedCards:(NSMutableArray *)cards
{
    _selectedCards = cards;
}

- (void) setMatchStatus:(BOOL)status
{
    _matchStatus = status;
}

- (void) updateStatus
{
    [self setNeedsDisplay];
}

- (void)drawCard:(SetCard *)card
{
    self.color = card.color;
    self.shape = card.shape;
    self.shapeCount = card.shapeCount;
    self.shapeType = card.shapeType;

    [self drawShapes];
}

- (void)drawShapes
{
    if (self.shape == SHAPE_DIAMOND) {
        for (int i = 0; i < self.shapeCount; i++) {
            [self drawDiamond:self.context width:DIAMOND_WIDTH height:DIAMOND_WIDTH x:self.posX y:10];
            self.posX += DIAMOND_WIDTH;
        }
        self.posX += PADDING;
    } else if (self.shape == SHAPE_OVAL) {
        for (int i = 0; i < self.shapeCount; i++) {
            [self drawOval:self.context rect:CGRectMake(0, 0, OVAL_WIDTH, 20) x:self.posX y:0];
            self.posX += OVAL_WIDTH;
        }
        self.posX += PADDING;
    } else if (self.shape == SHAPE_SQUIGGLE) {
        for (int i = 0; i < self.shapeCount; i++) {
            [self drawSquiggle:self.context width:SQUIGGLE_WIDTH height:20 offset:7 x:self.posX y:0];
            self.posX += SQUIGGLE_WIDTH - 7;
        }
    }
}



@end
