//
//  HomeTableViewController.m
//  iOSExercise
//
//  Created by Ramesh K on 23/11/15.
//  Copyright © 2015 Ramesh K. All rights reserved.
//

#import "HomeTableViewController.h"
#import "Parser.h"
#import "Facts.h"

@interface HomeTableViewController ()
{
    MBProgressHUD *hud;
    UIFont *fontBold;
    NSMutableArray *arrFacts;
}

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    arrFacts = [[NSMutableArray alloc] init];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [self addProgressIndicator];
    
    [self makeRequestToServer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods

-(void)addProgressIndicator
{
    fontBold = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelFont = fontBold;
    hud.labelText = @"Loading...";
    [self.view addSubview:hud];
}

-(void)makeRequestToServer
{
    [hud show:true];
    NSString *strUrl =  [strOnlineURL stringByAppendingString:strFacts];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSString *strTile = [responseObject objectForKey:@"title"];
        
        NSMutableArray *arrJsonFacts = [responseObject objectForKey:@"rows"];
        
        self.title = strTile;
        
        Parser *parserObj = [[Parser alloc] init];
        
        arrFacts = [parserObj ParseJsonToFacts:arrJsonFacts];
        
        [self.tableView reloadData];
        
        [hud hide:true];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [hud hide:true];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return arrFacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
     Facts *factObj = [arrFacts objectAtIndex:indexPath.row];
    
    cell.textLabel.text = factObj.strTitle;
    cell.detailTextLabel.text = factObj.strDescription;
    
    if(![factObj.strImgUrl isEqualToString:@""])
    {
        // Here we use the new provided sd_setImageWithURL: method to load the web image
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:factObj.strImgUrl]
                          placeholderImage:[UIImage imageNamed:@"Noimage.png"]];
    }
    else
    {
        NSLog(@"URL: %@",factObj.strImgUrl);
    }
   
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
