//
//  OPEducationPickerViewController.m
//  Popover
//
//  Created by Oleg Pochtovy on 26.01.15.
//  Copyright (c) 2015 Oleg Pochtovy. All rights reserved.
//

#import "OPEducationPickerViewController.h"

@interface OPEducationPickerViewController()

@end

@implementation OPEducationPickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionDone:)];
        
        [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
        
    }
    
    self.educationListArray = [NSArray arrayWithObjects:@"lower secondary", @"secondary", @"incomplete higher", @"higher", @"master", @"graduate", @"2 highers", @"3 highers", @"4 highers", @"4+ highers", nil];
    
    [self.educationListTableView selectRowAtIndexPath:self.checkmarkIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    if (self.checkmarkIndexPath == nil) {
        
        [self.delegate educationHasChangedInEducationList:self];
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    NSLog(@"educationPickerPopover is deallocated");
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.educationListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.educationListArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == self.checkmarkIndexPath.row) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        cell.highlighted = YES;
//        cell.selected = YES;
        
        cell.backgroundColor = [UIColor lightGrayColor];
        
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

#pragma mark - UITableViewDataDelegate
// called after the user changes the selection. -> to change self.checkmarkIndexPath.row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // override self.checkmarkIndex
    self.checkmarkIndexPath = indexPath;
    
    [self.educationListTableView reloadData];
    
    // each time we choose a new field in the education list delegate of this class executes the method  educationHasChangedInEducationList:
    [self.delegate educationHasChangedInEducationList:self];
    
}

#pragma mark - Actions
- (void)actionDone:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end