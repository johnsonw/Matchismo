//
//  SetCardView.h
//  Matchismo
//
//  Created by Will Johnson on 3/2/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetShapeView.h"

#define CORNER_RADIUS 12.0
#define DEFAULT_SHAPE 1
#define DEFAULT_COLOR 1
#define DEFAULT_SHAPE 1
#define DEFAULT_SHAPE_COUNT 1

#define SELECTED_ALPHA 0.5

@interface SetCardView : SetShapeView

@property (nonatomic) BOOL faceUp;

@end
