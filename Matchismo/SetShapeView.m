//
//  SetShapeView.m
//  Matchismo
//
//  Created by Will Johnson on 3/7/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetShapeView.h"

@implementation SetShapeView

/**
 * Draws diamonds
 */
- (void) drawDiamondsInCenterOfBounds:(NSUInteger)count context:(CGContextRef) aRef width:(float)boundingWidth height:(float)boundingHeight posX:(float) posX posY:(float) posY
{
    if (count == 1) {
        float width = boundingWidth * 0.35;
        float height = boundingHeight * 0.35;
        [self drawDiamond:aRef width:width height:height x:posX - (width * 0.5) y:posY];
    } else if (count == 2) {
        float width = boundingWidth * 0.35;
        float height = boundingHeight * 0.35;
        [self drawDiamond:aRef width:width height:height x:posX - (posX * 0.5) - (width * 0.5) y:posY];
        [self drawDiamond:aRef width:width height:height x:posX + (posX * 0.5) - (width * 0.5) y:posY];
    } else if (count == 3) {
        float width = boundingWidth * 0.25;
        float height = boundingHeight * 0.25;
        [self drawDiamond:aRef width:width height:height x:posX - (posX * 0.5) - (width * 0.5) y:posY];
        [self drawDiamond:aRef width:width height:height x:posX - (width * 0.5) y:posY];
        [self drawDiamond:aRef width:width height:height x:posX + (posX * 0.5) - (width * 0.5) y:posY];
    }
}

/**
 * Draws ovals
 */
- (void) drawOvalsInCenterOfBounds:(NSUInteger)count context:(CGContextRef) aRef width:(float)width height:(float)height posX:(float) posX posY:(float) posY
{
    if (count == 1) {
        [self drawOval:aRef rect:CGRectMake(0, 0, width, height) x:posX - (width * 0.5) y:posY - (height * 0.5)];
    } else if (count == 2) {
        [self drawOval:aRef rect:CGRectMake(0, 0, width, height) x:posX - (posX * 0.5) - (width * 0.5) y:posY - (height * 0.5)];
        [self drawOval:aRef rect:CGRectMake(0, 0, width, height) x:posX + (posX * 0.5) - (width * 0.5) y:posY - (height * 0.5)];
    } else if (count == 3) {
        [self drawOval:aRef rect:CGRectMake(0, 0, width, height) x:posX - (posX * 0.5) - (width * 0.5) y:posY - (height * 0.5)];
        [self drawOval:aRef rect:CGRectMake(0, 0, width, height) x:posX - (width * 0.5) y:posY - (height * 0.5)];
        [self drawOval:aRef rect:CGRectMake(0, 0, width, height) x:posX + (posX * 0.5) - (width * 0.5) y:posY - (height * 0.5)];
    }
    
}

- (void) drawSquigglesInCenterOfBounds:(float)count context:(CGContextRef) aRef width:(float)width height:(float)height posX:(float) posX posY:(float) posY offset:(float) offset

{
    if (count == 1) {
        [self drawSquiggle:aRef width:width height:height offset:offset x:posX - (width * 0.5) y:posY - (height * 0.5)];
    } else if (count == 2) {
        [self drawSquiggle:aRef width:width height:height offset:offset x:posX - (posX * 0.5) - (width * 0.5) y:posY - (height * 0.5)];
        [self drawSquiggle:aRef width:width height:height offset:offset x:posX + (posX * 0.5) - (width * 0.5) y:posY - (height * 0.5)];
    } else if (count == 3) {
        [self drawSquiggle:aRef width:width height:height offset:offset x:posX - (posX * 0.5) - (width * 0.5) y:posY - (height * 0.5)];
        [self drawSquiggle:aRef width:width height:height offset:offset x:posX - (width * 0.5) y:posY - (height * 0.5)];
        [self drawSquiggle:aRef width:width height:height offset:offset x:posX + (posX * 0.5) - (width * 0.5) y:posY - (height * 0.5)];
    }
}

/**
 Draws a squiggle in the specified location.
 */
- (void) drawSquiggle:(CGContextRef)context width:(int)width height:(int)height offset:(int)offset x:(float)x y:(float)y
{
    // If you have content to draw after the shape,
    // save the current state before changing the transform.
    CGContextSaveGState(context);
    
    UIBezierPath *shape = [UIBezierPath bezierPath];
    // Initial curve
    CGPoint startP;
    startP.x = 0;
    startP.y = 0;
    CGPoint controlP1;
    controlP1.x = -offset;
    controlP1.y = height * 0.5;
    CGPoint controlP2;
    controlP2.x = offset;
    controlP2.y = height * 0.5;
    CGPoint targetP;
    targetP.x = 0;
    targetP.y = height;
    
    // Drop down
    CGPoint point3;
    point3.x = targetP.x + offset;
    point3.y = targetP.y;
    CGPoint point4;
    point4.x = startP.x + offset;
    point4.y = startP.y;
    
    [shape moveToPoint:startP];
    [shape addCurveToPoint:targetP controlPoint1:controlP1 controlPoint2:controlP2];
    [shape addLineToPoint:point3];
    [shape addCurveToPoint:point4 controlPoint1:controlP2 controlPoint2:controlP1];
    [shape closePath];
    
    // Translate the shape to the specified location
    CGContextTranslateCTM(context, x, y);
    
    [[self getShapeColor] setStroke];
    [self setFill];
    
    [self applyFillToShape:shape top:0 bottom:height width:width];
    
    // Stroke and fill as necessary
    [shape stroke];
    
    // Restore the graphics state before drawing any other content.
    CGContextRestoreGState(context);
}

/**
 Draws an oval in the specified location.
 */
- (void) drawOval:(CGContextRef)context rect:(CGRect)rect x:(float)x y:(float)y
{
    // If you have content to draw after the shape,
    // save the current state before changing the transform.
    CGContextSaveGState(context);
    
    UIBezierPath *shape = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(rect.size.width * 0.5, 5)];
    
    // Translate the shape to the specified location
    CGContextTranslateCTM(context, x, y);
    
    [[self getShapeColor] setStroke];
    [self setFill];
    
    [self applyFillToShape:shape top:0 bottom:rect.size.height width:rect.size.width];
    
    // Stroke and fill as necessary
    [shape stroke];
    
    // Restore the graphics state before drawing any other content.
    CGContextRestoreGState(context);
}

/**
 Draws a squiggle in the specified location.
 */
- (void) drawDiamond:(CGContextRef)context width:(int)width height:(int)height x:(float)x y:(float)y
{
    // If you have content to draw after the shape,
    // save the current state before changing the transform.
    CGContextSaveGState(context);
    
    UIBezierPath *shape = [UIBezierPath bezierPath];
    // Initial curve
    CGPoint startP;
    startP.x = 0;
    startP.y = 0;
    CGPoint point2;
    point2.x = (width * 0.5);
    point2.y = -(height * 0.5);
    CGPoint point3;
    point3.x = width;
    point3.y = startP.y;
    CGPoint point4;
    point4.x = (width * 0.5);
    point4.y = (height * 0.5);
    
    [shape moveToPoint:startP];
    [shape addLineToPoint:point2];
    [shape addLineToPoint:point3];
    [shape addLineToPoint:point4];
    [shape closePath];
    
    // Translate the shape to the specified location
    CGContextTranslateCTM(context, x, y);
    
    [[self getShapeColor] setStroke];
    [self setFill];
    
    [self applyFillToShape:shape top:-height bottom:height width:width];
    
    // Stroke and fill as necessary
    [shape stroke];
    
    // Restore the graphics state before drawing any other content.
    CGContextRestoreGState(context);
}

- (void) applyFillToShape:(UIBezierPath *)shape top:(int)top bottom:(int)bottom width:(int)width
{
    if (self.shapeType == SHAPE_TYPE_STRIPED) {
        [self stripeShape:shape top:top bottom:bottom width:width];
        [shape addClip];
    }
    
    [shape fill];
}

- (void) stripeShape:(UIBezierPath *)shape top:(float)top bottom:(float)bottom width:(float)width
{
    int curPos = top;
    while (curPos < bottom) {
        [shape moveToPoint:CGPointMake(0, curPos)];
        [shape addLineToPoint:CGPointMake(width, curPos)];
        curPos += 3;
    }
}

- (void) setFill
{
    [[UIColor clearColor] setFill];
    if (self.shapeType == SHAPE_TYPE_SOLID) {
        [[self getShapeColor] setFill];
    }
}

/**
 * Returns a UIColor object based on the color set on this view.
 */
- (UIColor *) getShapeColor
{
    UIColor *color;
    if (self.color == COLOR_RED) {
        color = [UIColor redColor];
    } else if (self.color == COLOR_GREEN) {
        color = [UIColor greenColor];
    } else if (self.color == COLOR_BLUE) {
        color = [UIColor blueColor];
    }
    
    return color;
}

- (void) setShape:(NSUInteger)shape
{
    _shape = shape;
    // Indicate that we need to redraw
    [self setNeedsDisplay];
}

- (void) setColor:(NSUInteger)color
{
    _color = color;
    // Indicate that we need to redraw
    [self setNeedsDisplay];
}

- (void) setShapeType:(NSUInteger)shapeType
{
    _shapeType = shapeType;
    // Indicate that we need to redraw
    [self setNeedsDisplay];
}

- (void) setShapeCount:(NSUInteger)shapeCount
{
    _shapeCount = shapeCount;
    // Indicate that we need to redraw
    [self setNeedsDisplay];
}

- (CGContextRef) context
{
    return UIGraphicsGetCurrentContext();
}

/**
 * Initialization
 */
- (void) setup
{
    self.contentMode = UIViewContentModeRedraw;
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
