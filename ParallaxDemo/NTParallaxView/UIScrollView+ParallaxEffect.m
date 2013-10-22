//
//  UIScrollView+ParallaxEffect.m
//  PathPullToRefreshDemo
//
//  Created by demon on 8/29/13.
//  Copyright (c) 2013 demonNico. All rights reserved.
//

#import "UIScrollView+ParallaxEffect.h"

@interface UIScrollView ()

@property(nonatomic,strong) UIView * parallaxBackgroundView;
@property(nonatomic,strong) UIScrollView * parallaxContainer;
@property(nonatomic,assign) CGFloat windowHeight;
@property(nonatomic,assign) CGFloat dragDistanceLimit;
@property(nonatomic,assign) CGFloat parallaxFactor;

@end


@implementation UIScrollView (ParallaxEffect)

SYNTHESIZE_CATEGORY_OBJ_PROPERTY(parallaxBackgroundView, setParallaxBackgroundView:)
SYNTHESIZE_CATEGORY_OBJ_PROPERTY(parallaxContainer, setParallaxContainer:)
SYNTHESIZE_CATEGORY_VALUE_PROPERTY(CGFloat, windowHeight, setWindowHeight:)
SYNTHESIZE_CATEGORY_VALUE_PROPERTY(CGFloat, dragDistanceLimit,setDragDistanceLimit:)
SYNTHESIZE_CATEGORY_VALUE_PROPERTY(CGFloat, parallaxFactor, setParallaxFactor:)

char * draggingBlockKey;
-(void)setDraggingBlock:(dragBlock)draggingBlock
{
    objc_setAssociatedObject(self,
                             &draggingBlockKey,
                             draggingBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(dragBlock)draggingBlock
{
    return objc_getAssociatedObject(self,
                                    &draggingBlockKey);
}

char * finishBlockKey;
-(void)setFinishDragBlock:(dragBlock)finishDragBlock
{
    objc_setAssociatedObject(self,
                             &finishBlockKey,
                             finishDragBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(dragBlock)finishDragBlock
{
    return objc_getAssociatedObject(self, &finishBlockKey);
}

-(void)addBackgroundView:(UIView*)backgroundView
        withWindowHeight:(CGFloat)windowHeight
       dragDistanceLimit:(CGFloat)limitDistance
          parallaxFactor:(CGFloat)factor
{
    if(!self.parallaxContainer)
    {
        self.parallaxContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                0,
                                                                                self.frame.size.width,
                                                                                backgroundView.height)];
        [self addSubview:self.parallaxContainer];
        self.parallaxContainer.backgroundColor = [UIColor clearColor];
        
        [self addObserver:self
               forKeyPath:@"contentOffset"
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  context:NULL];
    }
    
    if(self.parallaxBackgroundView)
        [self.parallaxBackgroundView removeFromSuperview];
    
    self.parallaxFactor = factor;
    self.parallaxBackgroundView = backgroundView;
    self.windowHeight = windowHeight;
    self.dragDistanceLimit = limitDistance;
    self.parallaxContainer.height = backgroundView.height;
    self.parallaxContainer.contentSize = backgroundView.frame.size;
    self.parallaxContainer.bottom = windowHeight;
    backgroundView.top= (backgroundView.height-windowHeight)/2;
    
    [self.parallaxContainer addSubview:backgroundView];
    
    if([self isKindOfClass:[UITableView class]])
    {
        UITableView * tableView = (UITableView*)self;
        UIView * emptyView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, windowHeight)];
        tableView.tableHeaderView = emptyView;
        // or you'll never recieve touch event in your parallaxView.
        emptyView.userInteractionEnabled= NO;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (self.superview && newSuperview == nil) {
        if (self.parallaxContainer)
        {
            [self removeObserver:self forKeyPath:@"contentOffset"];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    self.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    CGPoint old = [[change objectForKey:NSKeyValueChangeOldKey] CGPointValue];
    CGPoint new = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
    
	if (old.y==new.y)
		return;
    CGFloat absOffsetY = abs(new.y);
    [self contentOffsetUpdate:new.y];
    if(self.draggingBlock)
        self.draggingBlock(absOffsetY);
}

-(void)contentOffsetUpdate:(CGFloat)offsetY;
{
    if(!self.isDragging&&
       self.finishDragBlock)
    {
        self.finishDragBlock(abs(offsetY));
    }
    CGFloat deltaParallax = self.windowHeight-self.parallaxBackgroundView.height;
    if (offsetY > deltaParallax && offsetY < 0.0f) {
        CGFloat offsetParallax = floorf(offsetY*(-self.parallaxFactor));
        self.parallaxContainer.contentOffset = CGPointMake(0.0f, offsetParallax);
    }

    if(self.dragDistanceLimit>0
       &&offsetY<-self.dragDistanceLimit)
    {
        self.contentOffset = CGPointMake(0, -self.dragDistanceLimit);
    }
}

@end
