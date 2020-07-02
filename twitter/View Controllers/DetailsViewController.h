//
//  DetailsViewController.h
//  twitter
//
//  Created by Alyssa Tan on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TimelineViewController.h"

NS_ASSUME_NONNULL_BEGIN



@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, strong) TimelineViewController *controller;
@end

NS_ASSUME_NONNULL_END
