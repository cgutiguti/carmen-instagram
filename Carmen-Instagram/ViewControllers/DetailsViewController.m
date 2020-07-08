//
//  DetailsViewController.m
//  Carmen-Instagram
//
//  Created by Carmen Gutierrez on 7/8/20.
//  Copyright © 2020 Carmen Gutierrez. All rights reserved.
//

#import "DetailsViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import <PFImageView.h>

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postImageView.file = self.post.image;
    self.captionLabel.text = self.post.caption;
    self.userNameLabel.text = self.post.author.username;
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
