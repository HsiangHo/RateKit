//
//  RateWindowController.h
//  RateKit
//
//  Created by Jovi on 11/3/18.
//  Copyright © 2018 Jovi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum : NSUInteger {
    RateWindowPositionCenter,
    RateWindowPositionTopRight,
    RateWindowPositionTopLeft
} RateWindowPosition;

typedef enum : NSUInteger {
    RateResultRated,
    RateResultLater,
    RateResultTimeout
} RateResult;

typedef void(^RateCompletionCallback)(RateResult rlst);

@class RateConfigure;
@interface RateWindowController : NSWindowController

-(instancetype)initWithConfigure:(RateConfigure *)configure;
-(void)setRateTimeout:(NSInteger)nTimeout;
-(void)requestRateWindow:(RateWindowPosition)pos withRateCompletionCallback:(RateCompletionCallback)block;

@end
