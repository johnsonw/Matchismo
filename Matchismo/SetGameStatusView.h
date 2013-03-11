//
//  SetGameView.h
//  Matchismo
//
//  Created by Will Johnson on 3/6/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetShapeView.h"
#import "SetCard.h"

@interface SetGameStatusView : SetShapeView

@property (nonatomic, strong) NSMutableArray *selectedCards;
@property (nonatomic) BOOL matchStatus;

- (void)updateStatus;
@end
