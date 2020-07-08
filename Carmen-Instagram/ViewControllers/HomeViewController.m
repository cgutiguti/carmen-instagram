//
//  HomeViewController.m
//  Carmen-Instagram
//
//  Created by Carmen Gutierrez on 7/6/20.
//  Copyright © 2020 Carmen Gutierrez. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "ComposeViewController.h"
#import "PostCell.h"
#import "Post.h"
#import <PFImageView.h>


@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *postArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getTimeline];
    //refresh control init
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
}
- (IBAction)didTapLogOut:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    NSLog(@"User logged out successfully!");
    [self dismissViewControllerAnimated:true completion:nil];
}
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self getTimeline];
    [self.tableView reloadData];
    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
}
- (void)getTimeline{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.postArray = (NSMutableArray *)posts;
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            [self.tableView reloadData];
        } else {
            NSLog(@"Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier: @"PostCell"];
    Post *post = self.postArray[indexPath.row];
    cell.captionLabel.text = post.caption;
    [cell setPost:post];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArray.count;
}


@end
