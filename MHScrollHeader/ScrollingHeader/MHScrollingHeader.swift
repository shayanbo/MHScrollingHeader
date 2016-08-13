//
//  MHScrollingHeader.swift
//  Pods
//
//  Created by shayanbo on 16/8/12.
//
//

import Foundation
import KVOController
import UIKit

private var scrollViewContentOffPoint = NSNull()
public extension UIViewController {
    
    func scrollHeaderSetup(
        scrollViews: [UIScrollView],
        contentOffset: CGFloat,
        topConstraint: NSLayoutConstraint,
        flexibleViewHeight: CGFloat
    ){
        
        mScrollViews = scrollViews
        mContentOffset = contentOffset
        mTopConstraint = topConstraint
        mFlexibleViewHeight = flexibleViewHeight
        mLastContentOffset = -contentOffset
        
        var observers: [FBKVOController] = []
        for scrollView in scrollViews {
            scrollView.contentInset = UIEdgeInsetsMake(contentOffset, 0, 0, 0)
            scrollView.scrollIndicatorInsets = scrollView.contentInset
            scrollView.contentOffset = CGPointMake(0, -contentOffset)
            
            let observer = FBKVOController(observer: self)
            observers.append(observer)
            observer.observe(
                scrollView,
                keyPath: "contentOffset",
                options: [.Old, .New],
                block:
            { [unowned self] (_, _, _) in
                self.scroll(scrollView)
            })
            mObservers = observers
        }
    }
}

private extension UIViewController {
    
    func scroll(activeScrollView: UIScrollView) {
        
        let currentContentOffsetY = activeScrollView.contentOffset.y
        
        if currentContentOffsetY < -mContentOffset ||
            currentContentOffsetY + CGRectGetHeight(activeScrollView.frame) > activeScrollView.contentSize.height {
            return
        }
        
        let delta = currentContentOffsetY - mLastContentOffset
        let scrollUp = delta > 0
        if scrollUp {
            if mTopConstraint.constant - delta <= -(mContentOffset - mFlexibleViewHeight) {
                mTopConstraint.constant = -(mContentOffset - mFlexibleViewHeight)
            } else {
                mTopConstraint.constant -= delta
            }
        } else {
            if mTopConstraint.constant - delta >= 0 {
                mTopConstraint.constant = 0
            } else {
                mTopConstraint.constant -= delta
            }
        }
        mLastContentOffset = currentContentOffsetY
    }
}

// MARK: - Binded-Variable
private var topConstraintPointer = NSNull()
private var scrollViewsPointer = NSNull()
private var contentOffsetPointer = NSNull()
private var flexibleViewHeightPointer = NSNull()
private var lastContentOffsetPointer = NSNull()
private var observersPointer = NSNull()

private extension UIViewController {
    
    var mObservers: [FBKVOController]! {
        get{return objc_getAssociatedObject(self, &observersPointer) as? [FBKVOController]}
        set{objc_setAssociatedObject(self, &observersPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
    
    var mTopConstraint: NSLayoutConstraint! {
        get{return objc_getAssociatedObject(self, &topConstraintPointer) as? NSLayoutConstraint}
        set{objc_setAssociatedObject(self, &topConstraintPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
    
    var mScrollViews: [UIScrollView]! {
        get{return objc_getAssociatedObject(self, &scrollViewsPointer) as? [UIScrollView]}
        set{objc_setAssociatedObject(self, &scrollViewsPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
    
    var mContentOffset: CGFloat! {
        get{return objc_getAssociatedObject(self, &contentOffsetPointer) as? CGFloat}
        set{objc_setAssociatedObject(self, &contentOffsetPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
    
    var mFlexibleViewHeight: CGFloat! {
        get{return objc_getAssociatedObject(self, &flexibleViewHeightPointer) as? CGFloat}
        set{objc_setAssociatedObject(self, &flexibleViewHeightPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
    
    var mLastContentOffset: CGFloat! {
        get{return objc_getAssociatedObject(self, &lastContentOffsetPointer) as? CGFloat}
        set{objc_setAssociatedObject(self, &lastContentOffsetPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
}
