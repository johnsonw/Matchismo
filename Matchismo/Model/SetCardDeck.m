//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Will Johnson on 2/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    if (self) {
        // Loop through each type of shape, shape count, shape type, and color. There
        // should be a total of 81 cards created.
        for (id shape in [SetCard validShapes]) {
            for (id shapeCount in [SetCard validShapeCount]) {
                for (id shapeType in [SetCard validShapeTypes]) {
                    for (id color in [SetCard validColors]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = [(NSNumber *)shape integerValue];
                        card.shapeCount = [(NSNumber *)shapeCount integerValue];
                        card.shapeType = [(NSNumber *)shapeType integerValue];
                        card.color = (int) [(NSNumber *)color integerValue];

                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}


@end
