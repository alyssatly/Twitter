//
//  User.m
//  twitter
//
//  Created by Alyssa Tan on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

//Create Initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        //...
      // Initialize any other properties
    }
    return self;
}
/*
- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self){
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
    }
    return self;
}
 */

@end
