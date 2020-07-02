//
//  TweetCell.m
//  twitter
//
//  Created by Alyssa Tan on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapFavorite:(UIButton *)sender {
    // TODO: Update the local tweet model
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

-(void)refreshData{
    if(self.tweet.favorited == YES){
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }else{
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    if(self.tweet.retweeted == YES){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }else{
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    self.favLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    self.retweetLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
}

@end
