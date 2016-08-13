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
@property (nonatomic, weak) UITableView *tableView1;
@property (nonatomic, weak) UITableView *tableView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *headerLabel = [UIButton new];
    {
        [headerLabel setTitle:@"I'm Scrolling Header" forState:UIControlStateNormal];
        headerLabel.backgroundColor = [UIColor blueColor];
        headerLabel.userInteractionEnabled = YES;
        [self configLabel:headerLabel];
        [self.view addSubview:headerLabel];
        
        self.topConstraint = [NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:headerLabel.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        [self.view addConstraint:self.topConstraint];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headerLabel)]];
        [headerLabel addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:200]];
        
        {
            UIButton *leftLabel = [UIButton new];
            {
                [self configLabel:leftLabel];
                [leftLabel setTitle:@"Menu" forState:UIControlStateNormal];
                [leftLabel addTarget:self action:@selector(menu) forControlEvents:UIControlEventTouchUpInside];
                leftLabel.backgroundColor = [UIColor orangeColor];
                [headerLabel addSubview:leftLabel];
            }
            
            UIButton *rightLabel = [UIButton new];
            {
                [self configLabel:rightLabel];
                [rightLabel setTitle:@"More" forState:UIControlStateNormal];
                [rightLabel addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
                rightLabel.backgroundColor = [UIColor brownColor];
                [headerLabel addSubview:rightLabel];
            }
            
            //set al
            {
                [headerLabel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leftLabel][rightLabel(leftLabel)]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:NSDictionaryOfVariableBindings(leftLabel, rightLabel)]];
                [headerLabel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(160)-[leftLabel(rightLabel)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftLabel, rightLabel)]];
            }
        }
    }
    
    UITableView *tableView1 = [UITableView new];
    {
        tableView1.translatesAutoresizingMaskIntoConstraints = NO;
        tableView1.delegate = self;
        tableView1.dataSource = self;
        tableView1.tableFooterView = [UIView new];
        tableView1.backgroundColor = [UIColor purpleColor];
        self.tableView1 = tableView1;
        [self.view insertSubview:tableView1 belowSubview:headerLabel];
        
        {
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView1)]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView1)]];
        }
    }
    
    UITableView *tableView2 = [UITableView new];
    {
        tableView2.translatesAutoresizingMaskIntoConstraints = NO;
        tableView2.delegate = self;
        tableView2.dataSource = self;
        tableView2.tableFooterView = [UIView new];
        tableView2.backgroundColor = [UIColor purpleColor];
        self.tableView2 = tableView2;
        [self.view insertSubview:tableView2 belowSubview:headerLabel];
        
        {
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView2]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView2)]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView2]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView2)]];
        }
    }
    
    [self scrollHeaderSetup:@[tableView1, tableView2] contentOffset:200 topConstraint:self.topConstraint flexibleViewHeight:40];
}

- (void)more {
    self.tableView1.hidden = true;
    self.tableView2.hidden = false;
}

- (void)menu {
    self.tableView1.hidden = false;
    self.tableView2.hidden = true;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = @"I'm Cell";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

#pragma mark - Private
- (void)configLabel:(UIButton *)label {
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    label.titleLabel.textColor = [UIColor whiteColor];
    label.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
