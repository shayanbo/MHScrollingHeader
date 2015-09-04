# MHScrollingHeader
An Easy Way to Intergate Scrolling Header

[![Cocoapods](http://img.shields.io/cocoapods/v/MHScrollingHeader.svg?style=flat)](http://www.cocoapods.org/?q=mhscrollingheader)

A custom Category for UIViewController to enable the scrolling of the header alongside the
scrolling of an observed content view.

#Screenshot

![MHScrollingHeader](https://raw.githubusercontent.com/MickeyHub/MHScrollingHeader/master/MHScrollHeader/assets/Screenshot.gif)

#Setup with Cocoapods

```
pod 'MHScrollingHeader', '~> 0.0.1'
use_frameworks!
```

##Usage

Make sure to use AutoLayout for your App UI.

Use `mh_followScrollView :withOffset :forTopConstraint` to start following the scrolling of a scrollable view (e.g.: a `UIScrollView` or `UITableView`).

```objc
- (void)viewDidLoad {
    [self mh_followScrollView:tableView withOffset:136 forTopConstraint:self.topConstraint];
}
```

You need call `mh_headerScroll` method in scrollview's callback `scrollViewDidScroll:scrollView` to follow scroll action

```objc
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self mh_headerScroll];
}
```

Check out the sample project for more details.

#Author
[MickeyHub](http://weibo.com/u/2194071594)

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

