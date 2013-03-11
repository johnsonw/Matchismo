//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Will Johnson on 2/24/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CORNER_RADIUS 12.0
#define FONT_SIZE_PERCENTAGE 0.20

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;
@end
