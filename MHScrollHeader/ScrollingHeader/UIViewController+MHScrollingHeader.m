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
    
    [self mh_followScrollViews:@[scrollView] withOffset:offset forTopConstraint:topConstraint];
}

-(void) mh_followScrollViews:(NSArray*)scrollViews withOffset:(CGFloat)offset forTopConstraint:(NSLayoutConstraint*)topConstraint{
    
    //shared data
    self.topConstraint = topConstraint;
    self.offset = offset;
    self.topConstraintConstant = topConstraint.constant;
    
    //check scrollviews type
    NSParameterAssert(scrollViews);
    [scrollViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSParameterAssert([obj isKindOfClass:[UIScrollView class]]);
    }];
    
    self.scrollViews = scrollViews;
    [scrollViews enumerateObjectsUsingBlock:^(UIScrollView* scrollView, NSUInteger idx, BOOL *stop) {
        
        [self setLastContentOffsetY:-offset forScrollView:scrollView];
        scrollView.contentOffset = CGPointMake(0, -offset);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0);
        scrollView.scrollIndicatorInsets = scrollView.contentInset;
    }];
}

/*
 * must be called in the scrollviewDidScroll callback
 */
-(void) mh_headerScroll{
    
    //get contentoffset y
    [self.scrollViews enumerateObjectsUsingBlock:^(UIScrollView* scrollView, NSUInteger idx, BOOL *stop) {
        if (scrollView.tracking) {
            self.activeScrollView = scrollView;
            *stop = YES;
        }
    }];
    
    if (!self.activeScrollView) {
        return;
    }
    
    CGFloat contentOffsetY = self.activeScrollView.contentOffset.y;
    
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

//will called at initial method `mh_followScrollView...`
-(void)setLastContentOffsetY:(CGFloat)lastContentOffsetY forScrollView:(UIScrollView*)scrollView{
    
    NSMutableDictionary* lastOffsetGroup = objc_getAssociatedObject(self, &lastContentOffsetYKey);
    if (!lastOffsetGroup) {
        lastOffsetGroup = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &lastContentOffsetYKey, lastOffsetGroup, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [lastOffsetGroup setObject:@(lastContentOffsetY) forKey:@(scrollView.hash)];
}

static char lastContentOffsetYKey;
-(CGFloat) lastContentOffsetY{
    NSMutableDictionary* lastOffsetGroup = objc_getAssociatedObject(self, &lastContentOffsetYKey);
    return [[lastOffsetGroup objectForKey:@(self.activeScrollView.hash)] floatValue];
}

-(void) setLastContentOffsetY:(CGFloat)contentOffsetY{
    NSMutableDictionary* lastOffsetGroup = objc_getAssociatedObject(self, &lastContentOffsetYKey);
    [lastOffsetGroup setObject:@(contentOffsetY) forKey:@(self.activeScrollView.hash)];
}

-(void)setTopConstraint:(NSLayoutConstraint*) constraint{objc_setAssociatedObject(self, @selector(topConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
-(NSLayoutConstraint*)topConstraint{return objc_getAssociatedObject(self, @selector(topConstraint));}

-(void)setActiveScrollView:(UIScrollView*)scrollView{objc_setAssociatedObject(self, @selector(activeScrollView), scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
-(UIScrollView*)activeScrollView{return objc_getAssociatedObject(self, @selector(activeScrollView));}

-(void)setScrollViews:(NSArray*)scrollViews{objc_setAssociatedObject(self, @selector(scrollViews), scrollViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
-(NSArray*)scrollViews{return objc_getAssociatedObject(self, @selector(scrollViews));}

-(void)setOffset:(CGFloat)offset{objc_setAssociatedObject(self, @selector(offset), @(offset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
-(CGFloat)offset{return [objc_getAssociatedObject(self, @selector(offset)) floatValue];}

-(CGFloat)topConstraintConstant{return [objc_getAssociatedObject(self, @selector(topConstraintConstant)) floatValue];}
-(void) setTopConstraintConstant:(CGFloat)constant{objc_setAssociatedObject(self, @selector(topConstraintConstant), @(constant), OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

@end
