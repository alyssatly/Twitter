//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.rowHeight = 186;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self getTimeline];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(getTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    
}

-(void) getTimeline{
    // Get timeline
        [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
            if (tweets) {
                NSLog(@"😎😎😎 Successfully loaded home timeline");
                
    //            for (NSDictionary *dictionary in tweets) {
    //                Tweet
    //                NSString *text = dictionary[@"text"];
    //                NSLog(@"%@", dictionary);
    //                NSLog(@"%@", text);
    //                Tweet *myTweet = dictionary;
    //                [self.tweets addObject:dictionary];
    //            }
                self.tweets = (NSMutableArray *)tweets;
                //NSLog(@"here: %@", self.tweets);
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            }
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didTweet:(Tweet *)tweet{
    [self.tweets addObject:tweet];
    [self getTimeline];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqual:@"composeTweet"]){
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }else{
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.tweets[indexPath.row];
        DetailsViewController *detailViewController = (DetailsViewController *)[segue destinationViewController];
        detailViewController.tweet = tweet;
        detailViewController.controller = self;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.tweets[indexPath.row];
    cell.tweet = tweet;
    cell.screenNameLabel.text = tweet.user.name;
    cell.userNameCell.text = [NSString stringWithFormat:@"@%@",tweet.user.screenName];
    cell.timeLabel.text = tweet.createdAtString;
    cell.favLabel.text = [NSString stringWithFormat:@"%d",tweet.favoriteCount];
    cell.repliesLabel.text = [NSString stringWithFormat:@"%d",tweet.repliesCount];
    cell.retweetLabel.text = [NSString stringWithFormat:@"%d",tweet.retweetCount];
    cell.tweetContentLabel.text = tweet.text;
    if(cell.tweet.favorited == YES){
        [cell.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }else{
        [cell.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    if(cell.tweet.retweeted == YES){
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }else{
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    NSString *picURLString = tweet.user.profilePic;
    NSURL*picURL = [NSURL URLWithString:picURLString];
    cell.pictureView.image = nil;
    [cell.pictureView setImageWithURL:picURL];

    return cell;
}

- (IBAction)logoutPressed:(UIBarButtonItem *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];

}

@end
