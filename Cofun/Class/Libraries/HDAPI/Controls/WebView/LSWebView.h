//
//  LSWebView.h
//  VIN API Project
//
//  Created by SonHD on 4/1/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSWebView;

@protocol LSWebViewProgressDelegate <NSObject>
@optional
- (void)webView:(LSWebView*)webView didReceiveResourceNumber:(int)resourceNumber totalResources:(int)totalResources;

@end

@interface LSWebView : UIWebView{
    id <LSWebViewProgressDelegate> __unsafe_unretained progressDelegate;
}
@property (nonatomic, unsafe_unretained) id progressDelegate;

@property (nonatomic, assign) int resourceCount;
@property (nonatomic, assign) int resourceCompletedCount;

@end
