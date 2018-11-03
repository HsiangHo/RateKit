//
//  RateConfigure.h
//  RateKit
//
//  Created by Jovi on 11/3/18.
//  Copyright © 2018 Jovi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface RateConfigure : NSObject

@property (nonatomic, strong, readwrite)        NSImage         *icon;
@property (nonatomic, strong, readwrite)        NSString        *name;
@property (nonatomic, strong, readwrite)        NSString        *detailText;
@property (nonatomic, strong, readwrite)        NSString        *likeButtonTitle;
@property (nonatomic, strong, readwrite)        NSString        *ignoreButtonTitle;
@property (nonatomic, strong, readwrite)        NSURL           *rateURL;

@end
