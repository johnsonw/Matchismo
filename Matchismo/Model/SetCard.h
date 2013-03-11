//
//  SetCard.h
//  Matchismo
//
//  Created by Will Johnson on 2/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Card.h"

#define COLOR_RED 1
#define COLOR_GREEN 2
#define COLOR_BLUE 3

#define SHAPE_TYPE_FULL 1
#define SHAPE_TYPE_DASHED 2
#define SHAPE_TYPE_STROKE 3

#define SHAPE_COUNT_ONE 1
#define SHAPE_COUNT_TWO 2
#define SHAPE_COUNT_THREE 3

#define SHAPE_ONE 1
#define SHAPE_TWO 2
#define SHAPE_THREE 3

#define SET_COUNT 3

@interface SetCard : Card
@property (nonatomic) int shape;
@property (nonatomic) int shapeCount;
@property (nonatomic) int shapeType;
@property (nonatomic) int color;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShapeTypes;
+ (NSArray *)validShapeCount;
@end
