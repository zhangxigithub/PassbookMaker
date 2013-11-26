//
//  TypeViewController.m
//  PassMaker
//
//  Created by 张 玺 on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import "StoreViewController.h"
#import "EditViewController.h"
#import <MobClick.h>

@implementation StoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@",segue);
    if([segue.identifier isEqualToString:@"push.edit"])
    {
        EditViewController *editViewController = segue.destinationViewController;
        NSIndexPath *path = [self.table indexPathForSelectedRow];
        [self.table deselectRowAtIndexPath:path animated:YES];
        editViewController.store = localData[path.row];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [MobClick event:@"enter_list"];
    localData = [[DataCenter sharedDataCenter] stores];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return localData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    StoreCell *cell = (StoreCell *)[tableView dequeueReusableCellWithIdentifier:@"typeCell" forIndexPath:indexPath];

    cell.store = localData[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
