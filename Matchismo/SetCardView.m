//
//  SetCardView.m
//  Matchismo
//
//  Created by Will Johnson on 3/2/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCardView.h"
#import "SetShapeView.h"

@implementation SetCardView

- (void) drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    // Add the rounded rect clip
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    if (self.faceUp) {
        self.alpha = SELECTED_ALPHA;
    }
    
    // Set the stroke color to black
    [[UIColor blackColor] setStroke];
    
    // Add the stroke
    [roundedRect stroke];
    [roundedRect fill];
    
    // Draw the shape(s) on the card
    [self drawShapesOnCard];
}

- (void) drawShapesOnCard
{
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    float centerX = self.bounds.size.width * 0.5;
    float centerY = self.bounds.size.height * 0.5;
    float offset = self.bounds.size.width * 0.15;
    
    // Draw the correct graphic based on the settings
    if (self.shape == SHAPE_DIAMOND) {
        [self drawDiamondsInCenterOfBounds:self.shapeCount context:aRef width:self.bounds.size.height height:self.bounds.size.height posX:centerX posY: centerY];
    } else if (self.shape == SHAPE_OVAL) {
        [self drawOvalsInCenterOfBounds:self.shapeCount context:aRef width:10 height:25 posX:centerX posY:centerY];
        
    } else if (self.shape == SHAPE_SQUIGGLE) {
        [self drawSquigglesInCenterOfBounds:self.shapeCount context:aRef width:10 height:25 posX:centerX posY:centerY offset:offset];
    }
}


/**
 * Initialization
 */
- (void) setup
{

}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
