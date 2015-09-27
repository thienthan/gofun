//
//  LSWebView.m
//  VIN API Project
//
//  Created by SonHD on 4/1/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import "LSWebView.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@interface UIWebView ()
- (id)webView:(id)view identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource;
- (void)webView:(id)view resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource;
- (void)webView:(id)view resource:(id)resource didFailLoadingWithError:(id)error fromDataSource:(id)dataSource;

@end

@implementation LSWebView
@synthesize progressDelegate;

#pragma mark - Initialize
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)initialize {
    
}

#pragma mark - 
- (id)webView:(id)view identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource {
    
    [super webView:view identifierForInitialRequest:initialRequest fromDataSource:dataSource];
    
    return [NSNumber numberWithInt:self.resourceCount++];
}

- (void)webView:(id)view resource:(id)resource didFailLoadingWithError:(id)error fromDataSource:(id)dataSource {
    
    [super webView:view resource:resource didFailLoadingWithError:error fromDataSource:dataSource];
    self.resourceCompletedCount++;
    
    if ([self.progressDelegate respondsToSelector:@selector(webView:didReceiveResourceNumber:totalResources:)]) {
        [self.progressDelegate webView:self didReceiveResourceNumber:self.resourceCompletedCount totalResources:self.resourceCount];
    }
}

- (void)webView:(id)view resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource {
    
    [super webView:view resource:resource didFinishLoadingFromDataSource:dataSource];
    self.resourceCompletedCount++;
    
    if ([self.progressDelegate respondsToSelector:@selector(webView:didReceiveResourceNumber:totalResources:)]) {
        [self.progressDelegate webView:self didReceiveResourceNumber:self.resourceCompletedCount totalResources:self.resourceCount];
    }
}

@end
