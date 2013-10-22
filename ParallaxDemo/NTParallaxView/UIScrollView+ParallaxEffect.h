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

/**
 *	add parallax effect on UIScrollView obejct.
 *
 *	@param	backgroundView	backgroundView behind
 *	@param	windowHeight	default height of visible area
 *	@param	limitDistance	if you wanna stop drag action by some reason, set limitDistance
 *	@param	factor          change the rate of parallax's background view appearing, it's better (0-0.5].
 */
-(void)addBackgroundView:(UIView*)backgroundView
        withWindowHeight:(CGFloat)windowHeight
       dragDistanceLimit:(CGFloat)limitDistance
          parallaxFactor:(CGFloat)factor;
@property (nonatomic,copy) dragBlock draggingBlock;
@property (nonatomic,copy) dragBlock finishDragBlock;
@end
