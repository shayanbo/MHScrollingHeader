//
//  UIViewController+MHScrollingHeader.h
//  MHScrollingHeader
//
//  Created by MickeyHub on 15/9/3.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MHScrollingHeader)

-(void) mh_followScrollViews:(NSArray*)scrollViews withOffset:(CGFloat)offset forTopConstraint:(NSLayoutConstraint*)topConstraint;

-(void) mh_followScrollView:(UIScrollView*)scrollView withOffset:(CGFloat)offset forTopConstraint:(NSLayoutConstraint*)topConstraint;

-(void) mh_headerScroll;

@end
