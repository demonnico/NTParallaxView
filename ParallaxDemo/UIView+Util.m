//
//  UIView+Util.m
//  ParallaxDemo
//
//  Created by demon on 9/12/13.
//  Copyright (c) 2013 demonNico. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)

-(void)setHeight:(CGFloat)height
{
    self.frame =CGRectMake(self.frame.origin.x,
                           self.frame.origin.y,
                           self.frame.size.width,
                           height);
}
-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setWidth:(CGFloat)width
{
    self.frame =CGRectMake(self.frame.origin.x,
                           self.frame.origin.y,
                           width,
                           self.frame.size.height);
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setBottom:(CGFloat)bottom
{
    self.frame =CGRectMake(self.frame.origin.x,
                           bottom-self.height,
                           self.width,
                           self.height);
}

-(CGFloat)bottom
{
    return self.frame.origin.y+self.height;
}

-(void)setTop:(CGFloat)top
{
    self.frame =CGRectMake(self.frame.origin.x,
                           top,
                           self.width,
                           self.height);
}

-(CGFloat)top
{
    return self.frame.origin.y;
}

@end
