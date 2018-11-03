//
//  AppDelegate.m
//  RateKitDemo
//
//  Created by Jovi on 11/3/18.
//  Copyright © 2018 Jovi. All rights reserved.
//

#import "AppDelegate.h"
#import <RateKit/RateKit.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    RateConfigure *configure = [[RateConfigure alloc] init];
    [configure setName:@"Love Ratekit?"];
    [configure setIcon:[NSImage imageNamed:@"demo-icon"]];
    [configure setDetailText:@"We look forward to your Star and Pull Request to make Ratekit better and better : )\n⭐️⭐️⭐️⭐️⭐️"];
    [configure setLikeButtonTitle:@"Star Now!"];
    [configure setIgnoreButtonTitle:@"Maybe later"];
    [configure setRateURL:[NSURL URLWithString:@"https://github.com/HsiangHo/RateKit"]];
    
    static RateWindowController *rateWindowController = nil;
    rateWindowController = [[RateWindowController alloc] initWithConfigure:configure];
    [rateWindowController setRateTimeout:10];
    [rateWindowController requestRateWindow:RateWindowPositionTopRight withRateCompletionCallback:^(RateResult rlst) {
        NSLog(@"%lu",(unsigned long)rlst);
    }];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
