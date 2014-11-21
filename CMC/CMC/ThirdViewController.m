//
//  ThirdViewController.m
//  CMC
//
//  Created by Christopher Rockwell on 11/20/14.
//  Copyright (c) 2014 Christopher Rockwell. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
NSArray *saves;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // read saves data from txt file
    NSString* path = [[NSBundle mainBundle] pathForResource:@"saves"
                                                     ofType:@"txt"];
    saves = [[NSString stringWithContentsOfFile:path
                                      encoding:NSUTF8StringEncoding
                                         error:nil]
             componentsSeparatedByString:@"\n"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return saves.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Raleway-Medium" size:16.0]];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [saves objectAtIndex:indexPath.row];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
