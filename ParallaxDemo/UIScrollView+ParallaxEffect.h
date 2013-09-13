//
//  UIScrollView+ParallaxEffect.h
//  PathPullToRefreshDemo
//
//  Created by demon on 8/29/13.
//  Copyright (c) 2013 demonNico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryPropertyUtil.h"
#import "UIView+Util.h"

typedef void (^dragBlock)(CGFloat offsetY);
@interface UIScrollView (ParallaxEffect)
-(void)addForegroundView:(UIView*)foreground
        withWindowHeight:(CGFloat)windowHeight
       dragDistanceLimit:(CGFloat)limitDistance
          parallaxFactor:(CGFloat)factor;
@property (nonatomic,copy) dragBlock draggingBlock;
@property (nonatomic,copy) dragBlock finishDragBlock;
@end
