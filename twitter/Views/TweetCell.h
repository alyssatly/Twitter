//
//  TweetCell.h
//  twitter
//
//  Created by Alyssa Tan on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *pictureView;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameCell;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetContentLabel;
@property (strong, nonatomic) IBOutlet UIButton *repliesButton;
@property (strong, nonatomic) IBOutlet UILabel *repliesLabel;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;
@property (strong, nonatomic) IBOutlet UILabel *retweetLabel;
@property (strong, nonatomic) IBOutlet UIButton *favButton;
@property (strong, nonatomic) IBOutlet UILabel *favLabel;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;

@property (strong, nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
