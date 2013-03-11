//
//  SetCard.m
//  Matchismo
//
//  Created by Will Johnson on 2/17/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validColors
{
    static NSArray *validColors = nil;
    if (!validColors) validColors = @[@(COLOR_RED), @(COLOR_GREEN), @(COLOR_BLUE)];
    return validColors;
}

+ (NSArray *)validShapeTypes
{
    static NSArray *validShapeTypes = nil;
    if (!validShapeTypes) validShapeTypes = @[@(SHAPE_TYPE_FULL), @(SHAPE_TYPE_STROKE), @(SHAPE_TYPE_DASHED)];
    return validShapeTypes;
}

+ (NSArray *)validShapeCount
{
    static NSArray *validShapeCount = nil;
    if (!validShapeCount) validShapeCount = @[@(SHAPE_COUNT_ONE), @(SHAPE_COUNT_TWO), @(SHAPE_COUNT_THREE)];
    return validShapeCount;
}

- (NSString *)description
{
    return [self contents];
}

// TODO: Implement this
- (NSString *)contents
{
    return @"";
}

@synthesize shape = _shape;
- (void)setShape:(int)shape
{
    if ([[SetCard validShapes] containsObject:@(shape)]) {
        _shape = shape;
    }
}

- (int)shape
{
    return _shape ? _shape : SHAPE_ONE;
}

@synthesize color = _color;
- (int) getColor
{
    return (_color) ? _color : COLOR_BLUE;
}

- (void)setColor:(int) value
{
    // If the value being passed in is one of the acceptable colors then set the value.
    if ([[SetCard validColors] containsObject:@(value)]) {
        _color = value;
    }
}

@synthesize shapeType = _shapeType;
- (int) getShapeType
{
    return (_shapeType) ? _shapeType : SHAPE_TYPE_FULL;
}

- (void) setShapeType:(int)shapeType
{
    if ([[SetCard validShapeTypes] containsObject:@(shapeType)]) {
        _shapeType = shapeType;
    }
}

@synthesize shapeCount = _shapeCount;
- (int) getShapeCount
{
    return (_shapeCount) ? _shapeCount : SHAPE_COUNT_ONE;
}

- (void) setShapeCount:(int)shapeCount
{
    if ([[SetCard validShapeCount] containsObject:@(shapeCount)]) {
        _shapeCount = shapeCount;
    }
}

+ (NSArray *)validShapes
{
    return @[@(SHAPE_ONE), @(SHAPE_TWO), @(SHAPE_THREE)];
}

/**
 * Indicates if this card creates a set with the other cards that are passed in.
 */
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    NSMutableArray *shapesArray = [[NSMutableArray alloc] init];
    NSMutableArray *shapeCountArray = [[NSMutableArray alloc] init];
    NSMutableArray *colorArray = [[NSMutableArray alloc] init];
    NSMutableArray *shapeTypesArray = [[NSMutableArray alloc] init];
    
    // There are four conditions to create a matched set:
    // 1. They all have the same number, or they have three different numbers.
    // 2. They all have the same symbol, or they have three different symbols.
    // 3. They all have the same shading, or they have three different shadings.
    // 4. They all have the same color, or they have three different colors.

    [shapesArray addObject:@([self shape])];
    [colorArray addObject:@([self color])];
    [shapeTypesArray addObject:@([self shapeType])];
    [shapeCountArray addObject:@([self shapeCount])];
    for (id otherCard in otherCards) {
        if ([otherCard isKindOfClass:[SetCard class]]) {
            SetCard *curCard = (SetCard *)otherCard;
            [shapesArray addObject:@([curCard shape])];
            [colorArray addObject: @([curCard color])];
            [shapeTypesArray addObject: @([curCard shapeType])];
            [shapeCountArray addObject:@([curCard shapeCount])];
        }
    }
    
    // Check 1:
    NSSet *uniqueShapeSet = [NSSet setWithArray:shapesArray];
    if (([uniqueShapeSet count] == SET_COUNT) || ([uniqueShapeSet count] == 1)) {
        NSLog(@"Match 1");
        score += 1;
    }
    
    // Check 2:
    NSSet *uniqueColorSet = [NSSet setWithArray:colorArray];
    if (([uniqueColorSet count] == SET_COUNT) || ([uniqueColorSet count] == 1)) {
        score += 1;
        NSLog(@"Match 2");
    }
    
    // Check 3:
    NSSet *uniqueShapeTypeSet = [NSSet setWithArray:shapeTypesArray];
    if (([uniqueShapeTypeSet count] == SET_COUNT) || ([uniqueShapeTypeSet count] == 1)) {
        score += 1;
        NSLog(@"Match 3");
    }
    
    // Check 4:
    NSSet *uniqueShapeCountSet = [NSSet setWithArray:shapeCountArray];
    if (([uniqueShapeCountSet count] == SET_COUNT) || ([uniqueShapeCountSet count] == 1)) {
        score += 1;
        NSLog(@"Match 4");
    }
    
    NSLog(@"score: %d", score);
    return score;
}


@end
