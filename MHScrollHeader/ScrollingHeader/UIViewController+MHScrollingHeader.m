//
//  UIViewController+MHScrollingHeader.m
//  OffsetDemo
//
//  Created by MickeyHub on 15/9/3.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "UIViewController+MHScrollingHeader.h"
#import <objc/runtime.h>

@implementation UIViewController (MHScrollingHeader)

/*
 * ready to scroll
 */
-(void) mh_followScrollView:(UIScrollView*)scrollView withOffset:(CGFloat)offset forTopConstraint:(NSLayoutConstraint*)topConstraint{
    
    self.topConstraint = topConstraint;
    self.scrollView = scrollView;
    self.offset = offset;
    self.topConstraintConstant = topConstraint.constant;
    self.lastContentOffsetY = -offset;
    
    scrollView.contentOffset = CGPointMake(0, -offset);
    scrollView.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0);
    scrollView.scrollIndicatorInsets = scrollView.contentInset;
}

/*
 * must be called in the scrollviewDidScroll callback
 */
-(void) mh_headerScroll{
    
    //get contentoffset y
    CGFloat contentOffsetY = self.scrollView.contentOffset.y;
    
    //scroll direction
    BOOL scrollUp = contentOffsetY - self.lastContentOffsetY > 0;
    
    //delta between 2 offsets
    CGFloat deltaY = fabs(contentOffsetY - self.lastContentOffsetY);
    
    //set last content offset y
    self.lastContentOffsetY = contentOffsetY;
    
    if (scrollUp) {
        
        if (contentOffsetY < -self.offset) {
            return;
        }
        
        if (self.topConstraint.constant <= -(self.topConstraintConstant + self.offset)) {
            self.topConstraint.constant = -(self.topConstraintConstant + self.offset);
            return;
        }
        self.topConstraint.constant -= deltaY;
    }else{
        
        if (self.topConstraint.constant >= self.topConstraintConstant) {
            self.topConstraint.constant = self.topConstraintConstant;
            return;
        }
        self.topConstraint.constant += deltaY;
    }
}

#pragma mark Getter & Setter
-(void)setTopConstraint:(NSLayoutConstraint*) constraint{objc_setAssociatedObject(self, @selector(topConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

-(NSLayoutConstraint*)topConstraint{return objc_getAssociatedObject(self, @selector(topConstraint));}

-(void)setScrollView:(UIScrollView*)scrollView{objc_setAssociatedObject(self, @selector(scrollView), scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

-(UIScrollView*)scrollView{return objc_getAssociatedObject(self, @selector(scrollView));}

-(void)setOffset:(CGFloat)offset{objc_setAssociatedObject(self, @selector(offset), @(offset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

-(CGFloat)offset{return [objc_getAssociatedObject(self, @selector(offset)) floatValue];}

-(CGFloat) lastContentOffsetY{return [objc_getAssociatedObject(self, @selector(lastContentOffsetY)) floatValue];}

-(void)setLastContentOffsetY:(CGFloat)lastContentOffsetY{objc_setAssociatedObject(self, @selector(lastContentOffsetY), @(lastContentOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

-(CGFloat)topConstraintConstant{
    return [objc_getAssociatedObject(self, @selector(topConstraintConstant)) floatValue];
}

-(void) setTopConstraintConstant:(CGFloat)constant{
    objc_setAssociatedObject(self, @selector(topConstraintConstant), @(constant), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
