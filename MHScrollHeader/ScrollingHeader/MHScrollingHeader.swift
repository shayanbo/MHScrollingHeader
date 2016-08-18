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
    ) {

        mScrollViews = scrollViews
        mContentOffset = contentOffset
        mTopConstraint = topConstraint
        mFlexibleViewHeight = flexibleViewHeight

        var observers: [FBKVOController] = []
        var lastContentOffsets: [UIScrollView: CGFloat] = [:]
        for scrollView in scrollViews {
            scrollView.contentInset = UIEdgeInsets(top: contentOffset, left: 0, bottom: 0, right: 0)
            scrollView.scrollIndicatorInsets = scrollView.contentInset
            scrollView.contentOffset = CGPoint(x: 0, y: -contentOffset)
            lastContentOffsets[scrollView] = -contentOffset

            let observer = FBKVOController(observer: self)
            observers.append(observer)
            observer.observe(
                scrollView,
                keyPath: "contentOffset",
                options: [.Old, .New],
                block: { [unowned self] (_, _, _) in

                if scrollView.tracking {
                    self.mActiveScrollView = scrollView
                }
                if scrollView === self.mActiveScrollView {
                    self.scroll(self.mActiveScrollView)
                }
            })
        }
        mObservers = observers
        mLastContentOffsets = lastContentOffsets
    }
}

private extension UIViewController {

    func scroll(activeScrollView: UIScrollView) {

        let currentContentOffsetY = activeScrollView.contentOffset.y

        if currentContentOffsetY < -mContentOffset ||
            currentContentOffsetY + activeScrollView.frame.height > activeScrollView.contentSize.height {
            return
        }

        let delta = currentContentOffsetY - mLastContentOffsets[activeScrollView]!
        let scrollUp = delta > 0
        if scrollUp {
            if mTopConstraint.constant - delta <= -(mContentOffset - mFlexibleViewHeight) {
                mTopConstraint.constant = -(mContentOffset - mFlexibleViewHeight)
            } else {
                mTopConstraint.constant -= delta
                adjustOtherScrollViews(activeScrollView)
            }
        } else {
            if mTopConstraint.constant - delta >= 0 {
                mTopConstraint.constant = 0
            } else {
                mTopConstraint.constant -= delta
                adjustOtherScrollViews(activeScrollView)
            }
        }
        mLastContentOffsets[activeScrollView] = currentContentOffsetY
    }

    func adjustOtherScrollViews(activeScrollView: UIScrollView) {

        let index = mScrollViews.indexOf(activeScrollView)!
        mScrollViews.removeAtIndex(index)
        mScrollViews.insert(activeScrollView, atIndex: 0)
        let scrollViews = mScrollViews.dropFirst()
        for scrollView in scrollViews {
            let delta = activeScrollView.contentOffset.y - mLastContentOffsets[activeScrollView]!
            mLastContentOffsets[scrollView] = mLastContentOffsets[scrollView]! + delta
            scrollView.contentOffset = CGPoint(x:0, y:mLastContentOffsets[scrollView]!)
        }
    }
}

// MARK: - Binded-Variable
private var topConstraintPointer = NSNull()
private var scrollViewsPointer = NSNull()
private var contentOffsetPointer = NSNull()
private var flexibleViewHeightPointer = NSNull()
private var lastContentOffsetPointer = NSNull()
private var activeScrollViewPointer = NSNull()
private var observersPointer = NSNull()

private extension UIViewController {

    var mObservers: [FBKVOController]! {
        get {return objc_getAssociatedObject(self, &observersPointer) as? [FBKVOController]}
        set {objc_setAssociatedObject(self, &observersPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    var mTopConstraint: NSLayoutConstraint! {
        get {return objc_getAssociatedObject(self, &topConstraintPointer) as? NSLayoutConstraint}
        set {objc_setAssociatedObject(self, &topConstraintPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    var mScrollViews: [UIScrollView]! {
        get {return objc_getAssociatedObject(self, &scrollViewsPointer) as? [UIScrollView]}
        set {objc_setAssociatedObject(self, &scrollViewsPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    var mActiveScrollView: UIScrollView! {
        get {return objc_getAssociatedObject(self, &activeScrollViewPointer) as? UIScrollView}
        set {objc_setAssociatedObject(self, &activeScrollViewPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    var mContentOffset: CGFloat! {
        get {return objc_getAssociatedObject(self, &contentOffsetPointer) as? CGFloat}
        set {objc_setAssociatedObject(self, &contentOffsetPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    var mFlexibleViewHeight: CGFloat! {
        get {return objc_getAssociatedObject(self, &flexibleViewHeightPointer) as? CGFloat}
        set {objc_setAssociatedObject(self, &flexibleViewHeightPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    var mLastContentOffsets: [UIScrollView: CGFloat]! {
        get {return objc_getAssociatedObject(self, &lastContentOffsetPointer) as? [UIScrollView: CGFloat]}
        set {objc_setAssociatedObject(self, &lastContentOffsetPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
}
