//
//  DetailsViewController.m
//  twitter
//
//  Created by Alyssa Tan on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "ComposeViewController.h"


@interface DetailsViewController () <ComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *screennameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *createdTimeLabel;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;
@property (strong, nonatomic) IBOutlet UILabel *retweetLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UILabel *likeLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.usernameLabel.text = self.tweet.user.name;
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    self.createdTimeLabel.text = self.tweet.createdAtString;
    self.likeLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    self.retweetLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    self.tweetLabel.text = self.tweet.text;
    if(self.tweet.favorited == YES){
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }else{
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    if(self.tweet.retweeted == YES){
        [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }else{
        [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    NSString *picURLString = self.tweet.user.profilePic;
    NSURL*picURL = [NSURL URLWithString:picURLString];
    self.profileImageView.image = nil;
    [self.profileImageView setImageWithURL:picURL];

}
- (IBAction)didTapRetweet:(UIButton *)sender {
    if(self.tweet.retweeted == NO){
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        // TODO: Update cell UI
           [self refreshData];
        
           // TODO: Send a POST request to the POST favorites/create endpoint
           [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
               if(error){
                    NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
               }
               else{
                   NSLog(@"Successfully retweeting the following Tweet: %@", tweet.text);
               }
           }];
    }else{
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        // TODO: Update cell UI
           [self refreshData];
        
           // TODO: Send a POST request to the POST favorites/create endpoint
           [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
               if(error){
                    NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
               }
               else{
                   NSLog(@"Successfully unretweeting the following Tweet: %@", tweet.text);
               }
           }];
        
    }
}

- (IBAction)didTapLike:(id)sender {
    if(self.tweet.favorited == NO){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        // TODO: Update cell UI
        [self refreshData];

        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }else{
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        // TODO: Update cell UI
        [self refreshData];

        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];

    }
}

-(void)refreshData{
    if(self.tweet.favorited == YES){
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }else{
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    if(self.tweet.retweeted == YES){
        [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }else{
        [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    self.likeLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    self.retweetLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
}

-(void)didTweet:(Tweet *)tweet{
    //[self.tweets addObject:tweet];
    //[self getTimeline];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    
    composeController.delegate = self;
    composeController.username = self.tweet.user.screenName;
    
}


@end
