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

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 186;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
            NSLog(@"here: %@", self.tweets);
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.tweets[indexPath.row];
    cell.screenNameLabel.text = tweet.user.name;
    cell.userNameCell.text = [NSString stringWithFormat:@"@%@",tweet.user.screenName];
    cell.timeLabel.text = tweet.createdAtString;
    cell.favLabel.text = [NSString stringWithFormat:@"%d",tweet.favoriteCount];
    cell.repliesLabel.text = [NSString stringWithFormat:@"%d",tweet.repliesCount];
    cell.retweetLabel.text = [NSString stringWithFormat:@"%d",tweet.retweetCount];
    cell.tweetContentLabel.text = tweet.text;
    
    NSString *picURLString = tweet.user.profilePic;
    NSURL*picURL = [NSURL URLWithString:picURLString];
    cell.pictureView.image = nil;
    [cell.pictureView setImageWithURL:picURL];

    return cell;
}


@end
