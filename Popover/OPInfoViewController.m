//
//  OPInfoViewController.m
//  Popover
//
//  Created by Oleg Pochtovy on 26.01.15.
//  Copyright (c) 2015 Oleg Pochtovy. All rights reserved.
//

#import "OPInfoViewController.h"

@implementation OPInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    NSLog(@"Info popover is deallocated");
}

#pragma mark - Actions
- (IBAction)actionDone:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end