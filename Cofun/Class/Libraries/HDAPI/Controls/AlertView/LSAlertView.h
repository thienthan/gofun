//
//  LSAlertView.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissBlockAlert)(NSInteger buttonIndex);
typedef void (^CancelBlockAlert)();

@interface LSAlertView : UIAlertView

+ (instancetype)alertViewWithTitle:(NSString*) title
                           message:(NSString*) message;

+ (instancetype)alertViewWithTitle:(NSString*) title
                           message:(NSString*) message
                 cancelButtonTitle:(NSString*) cancelButtonTitle;

+ (instancetype)alertViewWithTitle:(NSString*) title
                           message:(NSString*) message
                 cancelButtonTitle:(NSString*) cancelButtonTitle
                 otherButtonTitles:(NSArray*) otherButtonTitles
                      dismissBlock:(DismissBlockAlert) dismissBlock
                       cancelBlock:(CancelBlockAlert) cancelBlock;

- (instancetype)initWithTitle:(NSString*) title
                      message:(NSString*) message
            cancelButtonTitle:(NSString*) cancelButtonTitle
            otherButtonTitles:(NSArray*) otherButtonTitles
                 dismissBlock:(DismissBlockAlert) dismissBlock
                  cancelBlock:(CancelBlockAlert) cancelBlock;

- (instancetype)initWithTitle:(NSString*) title
                      message:(NSString*) message
            cancelButtonTitle:(NSString*) cancelButtonTitle
                 dismissBlock:(DismissBlockAlert) dismissBlock
                  cancelBlock:(CancelBlockAlert) cancelBlock
            otherButtonTitles:(NSString*) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)setFontName:(NSString*)fontName fontColor:(UIColor*)fontColor fontShadowColor:(UIColor*)fontShadowColor;
@end
