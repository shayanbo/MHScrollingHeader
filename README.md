# MHScrollingHeader
An Easy Way to Intergate Scrolling Header

[![CocoaPods](http://img.shields.io/cocoapods/v/MHScrollingHeader.svg?style=flat)](http://www.cocoapods.org/?q=mhscrollingheader)
[![CocoaPods](http://img.shields.io/cocoapods/l/MHScrollingHeader.svg?style=flat)](http://www.cocoapods.org/?q=mhscrollingheader)
[![CocoaPods](http://img.shields.io/cocoapods/p/MHScrollingHeader.svg?style=flat)](http://www.cocoapods.org/?q=mhscrollingheader)
[![Join the chat at https://gitter.im/MickeyHub/MHScrollingHeader](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/MickeyHub/MHScrollingHeader)
[![Contact](https://img.shields.io/badge/contact-Mickey-green.svg)](http://weibo.com/u/2194071594)

A custom Category for UIViewController to enable the scrolling of the header alongside the
scrolling of an observed content view.

#Screenshot

![MHScrollingHeader](https://raw.githubusercontent.com/MickeyHub/MHScrollingHeader/master/MHScrollHeader/assets/Screenshot.gif)

#Setup with CocoaPods

```
pod 'MHScrollingHeader', '~> 1.0.0'
use_frameworks!
```
# Manually from GitHub
1. Download the source files in the [MHScrollHeader subdirectory](MHScrollHeader/MHScrollingHeader).
2. Add the one and only one swift file to your Xcode project.

##Usage

Make sure to use AutoLayout for your App UI.

Just use `scrollHeaderSetup(_:contentOffset:topConstraint:flexibleViewHeight:)` to start following the scrolling of a scrollable view (e.g.: a `UIScrollView` or `UITableView`).

Example->OC: 

```objc
- (void)viewDidLoad {
    [self scrollHeaderSetup:@[tableView1, tableView2] contentOffset:200 topConstraint:self.topConstraint flexibleViewHeight:40];
}
```

Check out the sample project for more details.

#Author
[MickeyHub](https://about.me/MickeySha)

#MIT License
    The MIT License (MIT)

    Copyright (c) 2015 MickeySha

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

