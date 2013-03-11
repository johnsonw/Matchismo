//
//  SetShapeView.h
//  Matchismo
//
//  Created by Will Johnson on 3/7/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SHAPE_DIAMOND 1
#define SHAPE_SQUIGGLE 2
#define SHAPE_OVAL 3

#define SHAPE_TYPE_SOLID 1
#define SHAPE_TYPE_STRIPED 2
#define SHAPE_TYPE_UNFILLED 3

#define COLOR_RED 1
#define COLOR_GREEN 2
#define COLOR_BLUE 3

@interface SetShapeView : UIView

@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger shapeType;
@property (nonatomic) NSUInteger shapeCount;
@property (nonatomic) CGContextRef context;

- (void) drawDiamondsInCenterOfBounds:(NSUInteger)count context:(CGContextRef) aRef width:(float)boundingWidth height:(float)boundingHeight posX:(float) posX posY:(float)posY;
- (void) drawOvalsInCenterOfBounds:(NSUInteger)count context:(CGContextRef) aRef width:(float)width height:(float)height posX:(float) posX posY:(float) posY;
- (void) drawSquigglesInCenterOfBounds:(float)count context:(CGContextRef) aRef width:(float)width height:(float)height posX:(float) posX posY:(float) posY offset:(float) offset;
- (void) drawSquiggle:(CGContextRef)context width:(int)width height:(int)height offset:(int)offset x:(float)x y:(float)y;
- (void) drawOval:(CGContextRef)context rect:(CGRect)rect x:(float)x y:(float)y;
- (void) drawDiamond:(CGContextRef)context width:(int)width height:(int)height x:(float)x y:(float)y;


@end
