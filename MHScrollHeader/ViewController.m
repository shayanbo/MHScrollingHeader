//
//  ViewController.m
//  OffsetDemo
//
//  Created by MickeyHub on 15/9/2.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ViewController.h"
#import "MHScrollingHeader-Swift.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel *headerLabel = [UILabel new];
    {
        headerLabel.text = @"I'm Scrolling Header";
        headerLabel.backgroundColor = [UIColor blueColor];
        [self configLabel:headerLabel];
        [self.view addSubview:headerLabel];
        
        self.topConstraint = [NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:headerLabel.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        [self.view addConstraint:self.topConstraint];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headerLabel)]];
        [headerLabel addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:200]];
        
        {
            UILabel *leftLabel = [UILabel new];
            {
                [self configLabel:leftLabel];
                leftLabel.text = @"Menu";
                [headerLabel addSubview:leftLabel];
            }
            
            UILabel *rightLabel = [UILabel new];
            {
                [self configLabel:rightLabel];
                rightLabel.text = @"More";
                [headerLabel addSubview:rightLabel];
            }
            
            //set al
            {
                [headerLabel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leftLabel][rightLabel(leftLabel)]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:NSDictionaryOfVariableBindings(leftLabel, rightLabel)]];
                [headerLabel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(150)-[leftLabel(rightLabel)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftLabel, rightLabel)]];
            }
        }
    }
    
    UITableView *tableView = [UITableView new];
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
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
        }
    }
    
    [self scrollHeaderSetup:@[tableView] contentOffset:200 topConstraint:self.topConstraint flexibleViewHeight:40];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = @"Scrolling Header";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

#pragma mark - Private
- (void)configLabel:(UILabel *)label {
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
}

@end
