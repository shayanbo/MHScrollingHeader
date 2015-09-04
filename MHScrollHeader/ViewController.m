//
//  ViewController.m
//  OffsetDemo
//
//  Created by MickeyHub on 15/9/2.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+MHScrollingHeader.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSLayoutConstraint* topConstraint;
@property (nonatomic, weak) UITableView* tableView;

@end

@implementation ViewController

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel* headerLabel = [UILabel new];
    {
        headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        headerLabel.text = @"I'm Scrolling Header";
        headerLabel.font = [UIFont boldSystemFontOfSize:20];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.backgroundColor = [UIColor blueColor];
        [self.view addSubview:headerLabel];
        self.topConstraint = [NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:headerLabel.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        [self.view addConstraint:self.topConstraint];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headerLabel)]];
        [headerLabel addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:200]];
    }
    
    UITableView* tableView = [UITableView new];
    {
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        tableView.backgroundColor = [UIColor purpleColor];
        self.tableView = tableView;
        [self.view insertSubview:tableView belowSubview:headerLabel];
        
        {
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
        }
    }

    [self mh_followScrollView:tableView withOffset:136 forTopConstraint:self.topConstraint];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = @"Scrolling Header";
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 100;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self mh_headerScroll];
}

@end
