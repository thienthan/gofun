//
//  LSActionSheetView.h
//  VIN API Project
//
//  Created by SonHD on 9/30/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissBlockAction)(NSInteger buttonIndex);
typedef void (^CancelBlockAction)();
typedef void (^DestructiveBlockAction)();

@interface LSActionSheetView : UIActionSheet

+ (instancetype)actionSheetWithTitle:(NSString*) title
                   cancelButtonTitle:(NSString*) cancelButtonTitle
                   otherButtonTitles:(NSArray*) otherButtonTitles
                        dismissBlock:(DismissBlockAction) dismissBlock
                         cancelBlock:(CancelBlockAction) cancelBlock;


+ (instancetype)actionSheetWithTitle:(NSString*) title
                   cancelButtonTitle:(NSString*) cancelButtonTitle
              destructiveButtonTitle:(NSString*) destructiveButtonTitle
                   otherButtonTitles:(NSArray*) otherButtonTitles
                        dismissBlock:(DismissBlockAction) dismissBlock
                    destructiveBlock:(DestructiveBlockAction) destructiveBlock
                         cancelBlock:(CancelBlockAction) cancelBlock;

- (instancetype)initWithTitle:(NSString*) title
            cancelButtonTitle:(NSString*) cancelButtonTitle
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
            otherButtonTitles:(NSArray*) otherButtonTitles
                 dismissBlock:(DismissBlockAction) dismissBlock
             destructiveBlock:(DestructiveBlockAction) destructiveBlock
                  cancelBlock:(CancelBlockAction) cancelBlock;

- (instancetype)initWithTitle:(NSString*) title
            cancelButtonTitle:(NSString*) cancelButtonTitle
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                 dismissBlock:(DismissBlockAction) dismissBlock
             destructiveBlock:(DestructiveBlockAction) destructiveBlock
                  cancelBlock:(CancelBlockAction) cancelBlock
            otherButtonTitles:(NSString*) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
