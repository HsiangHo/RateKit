//
//  RateWindowController.m
//  RateKit
//
//  Created by Jovi on 11/3/18.
//  Copyright © 2018 Jovi. All rights reserved.
//

#import "RateWindowController.h"
#import "RateConfigure.h"

@interface RateWindowController ()

@end

@implementation RateWindowController{
    RateConfigure           *_configure;
    NSImageView             *_ivIcon;
    NSTextField             *_lbName;
    NSTextField             *_lbDetailText;
    NSButton                *_btnLike;
    NSButton                *_btnIgnore;
    NSInteger               _nTimeout;
    RateCompletionCallback  _block;
}

-(instancetype)initWithConfigure:(RateConfigure *)configure{
    if (self = [super init]) {
        _configure = configure;
        [self __initializeRateWindowController];
    }
    return self;
}

-(void)setRateTimeout:(NSInteger)nTimeout{
    _nTimeout = nTimeout;
}

-(void)requestRateWindow:(RateWindowPosition)pos withRateCompletionCallback:(RateCompletionCallback)block{
    _block = block;
    [self.window orderOut:nil];
    NSUInteger nGap = 10;
    NSRect rctScreen = [[NSScreen mainScreen] visibleFrame];
    NSRect rctTmpWnd = [self.window frame];
    NSRect rctWnd = [self.window frame];
    switch (pos) {
        case RateWindowPositionTopLeft:
            rctTmpWnd.origin.x = NSMinX(rctScreen) - NSWidth(rctWnd);
            rctTmpWnd.origin.y = NSMaxY(rctScreen) - NSHeight(rctWnd) - nGap;
            [self.window makeKeyAndOrderFront:nil];
            [self.window setFrame:rctTmpWnd display:NO];
            
            rctWnd.origin.x = NSMinX(rctScreen) + nGap;
            rctWnd.origin.y = NSMaxY(rctScreen) - NSHeight(rctWnd) - nGap;
            [[self.window animator]setFrame:rctWnd display:YES];
            break;
            
        case RateWindowPositionTopRight:
            rctTmpWnd.origin.x = NSMaxX(rctScreen);
            rctTmpWnd.origin.y = NSMaxY(rctScreen) - NSHeight(rctWnd) - nGap;
            [self.window makeKeyAndOrderFront:nil];
            [self.window setFrame:rctTmpWnd display:NO];
            
            rctWnd.origin.x = NSMaxX(rctScreen) - NSWidth(rctWnd) - nGap;
            rctWnd.origin.y = NSMaxY(rctScreen) - NSHeight(rctWnd) - nGap;
            [[self.window animator]setFrame:rctWnd display:YES];
            break;
            
        case RateWindowPositionCenter:
        default:
            [self.window makeKeyAndOrderFront:nil];
            [self.window center];
            break;
    }
    if (0 < _nTimeout) {
        [self performSelector:@selector(__timeoutFunc) withObject:nil afterDelay:_nTimeout];
    }
}

-(IBAction)likeButton_click:(id)sender{
    if (nil != [_configure rateURL]) {
        [[NSWorkspace sharedWorkspace] openURL:[_configure rateURL]];
    }
    [self.window orderOut:nil];
    if (NULL != _block) {
        _block(RateResultRated);
    }
}

-(IBAction)ignoreButton_click:(id)sender{
    [self.window orderOut:nil];
    if (NULL != _block) {
        _block(RateResultLater);
    }
}

#pragma mark - private methods

-(void)__initializeRateWindowController{
    _nTimeout = 0;
    _block = NULL;
    NSRect rctWindow = NSMakeRect(0, 0, 210, 306);
    NSWindow *window = [[NSWindow alloc] initWithContentRect:rctWindow styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskFullSizeContentView backing:NSBackingStoreBuffered defer:YES];
    [self setWindow:window];
    [window setLevel:NSFloatingWindowLevel];
    [window setTitlebarAppearsTransparent:YES];
    [window setTitleVisibility:NSWindowTitleHidden];
    [window setMovableByWindowBackground:YES];
    [window center];
    
    [window setBackgroundColor:[NSColor whiteColor]];
    
    _ivIcon = [[NSImageView alloc] initWithFrame:NSMakeRect((NSWidth(rctWindow) - 64) / 2, NSHeight(rctWindow) - 86, 64, 64)];
    [_ivIcon setImageScaling:NSImageScaleAxesIndependently];
    [window.contentView addSubview:_ivIcon];
    [_ivIcon setImage:[_configure icon]];
    
    _lbName = [[NSTextField alloc] initWithFrame:NSMakeRect(0, NSMinY(_ivIcon.frame) - 40, NSWidth(rctWindow), 30)];
    [_lbName setEditable:NO];
    [_lbName setBezeled:NO];
    [_lbName setSelectable:NO];
    [_lbName setTextColor:[NSColor colorWithCalibratedRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0]];
    [_lbName setBackgroundColor:[NSColor clearColor]];
    [_lbName setFont:[NSFont fontWithName:@"HelveticaNeue" size:21]];
    [_lbName setAlignment:NSCenterTextAlignment];
    [_lbName setStringValue:[_configure name]];
    [window.contentView addSubview:_lbName];
    
    _lbDetailText = [[NSTextField alloc] initWithFrame:NSMakeRect(35, NSMinY(_lbName.frame) - 100, NSWidth(rctWindow) - 70, 90)];
    [_lbDetailText setEditable:NO];
    [_lbDetailText setBezeled:NO];
    [_lbDetailText setSelectable:NO];
    [_lbDetailText setTextColor:[NSColor grayColor]];
    [_lbDetailText setBackgroundColor:[NSColor clearColor]];
    [_lbDetailText setFont:[NSFont fontWithName:@"HelveticaNeue" size:12]];
    [_lbDetailText setLineBreakMode:NSLineBreakByWordWrapping];
//    [_lbDetailText setAlignment:NSCenterTextAlignment];
    [_lbDetailText setStringValue:[_configure detailText]];
    [window.contentView addSubview:_lbDetailText];
    
    _btnLike = [[NSButton alloc] initWithFrame:NSMakeRect(30, NSMinY(_lbDetailText.frame) - 50, NSWidth(rctWindow) - 60, 40)];
    [_btnLike setTitle:[_configure likeButtonTitle]];
    [_btnLike setBezelStyle:NSRoundedBezelStyle];
    [_btnLike setFont:[NSFont fontWithName:@"HelveticaNeue" size:15]];
    [_btnLike setKeyEquivalent:@"\r"];
    [_btnLike setTarget:self];
    [_btnLike setAction:@selector(likeButton_click:)];
    [window.contentView addSubview:_btnLike];
    
    _btnIgnore = [[NSButton alloc] initWithFrame:NSMakeRect(30, NSMinY(_btnLike.frame) - 10, NSWidth(rctWindow) - 60, 15)];
    NSColor *color = [NSColor lightGrayColor];
    NSString *title = [_configure ignoreButtonTitle];
    NSMutableAttributedString *colorTitle = [[NSMutableAttributedString alloc] initWithString: title];
    [colorTitle addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [title length])];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSCenterTextAlignment];
    [colorTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    [colorTitle addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"HelveticaNeue" size:11] range:NSMakeRange(0, [title length])];
    [_btnIgnore setAttributedTitle:colorTitle];
    [_btnIgnore setTarget:self];
    [_btnIgnore setAction:@selector(ignoreButton_click:)];
    [_btnIgnore setBezelStyle:NSRoundRectBezelStyle];
    [_btnIgnore setBordered:NO];
    [window.contentView addSubview:_btnIgnore];
}

-(void)__timeoutFunc{
    if (self.window.isVisible) {
        [self.window orderOut:nil];
        if (NULL != _block) {
            _block(RateResultTimeout);
        }
    }
}

@end
