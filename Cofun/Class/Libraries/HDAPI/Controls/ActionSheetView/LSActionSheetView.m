//
//  LSActionSheetView.m
//  VIN API Project
//
//  Created by SonHD on 9/30/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "LSActionSheetView.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher

#endif

@interface LSActionSheetView ()<UIActionSheetDelegate>{
    
    DismissBlockAction _dismissBlock;
    CancelBlockAction _cancelBlock;
    DestructiveBlockAction _destructiveBlock;
}

@end

@implementation LSActionSheetView

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

+ (instancetype)actionSheetWithTitle:(NSString*) title
                   cancelButtonTitle:(NSString*) cancelButtonTitle
                   otherButtonTitles:(NSArray*) otherButtonTitles
                        dismissBlock:(DismissBlockAction) dismissBlock
                         cancelBlock:(CancelBlockAction) cancelBlock {
    
    return [self actionSheetWithTitle:title
                    cancelButtonTitle:cancelButtonTitle
               destructiveButtonTitle:nil
                    otherButtonTitles:otherButtonTitles
                         dismissBlock:dismissBlock
                     destructiveBlock:nil
                          cancelBlock:cancelBlock];
}


+ (instancetype)actionSheetWithTitle:(NSString*) title
                   cancelButtonTitle:(NSString*) cancelButtonTitle
              destructiveButtonTitle:(NSString*) destructiveButtonTitle
                   otherButtonTitles:(NSArray*) otherButtonTitles
                        dismissBlock:(DismissBlockAction) dismissBlock
                    destructiveBlock:(DestructiveBlockAction) destructiveBlock
                         cancelBlock:(CancelBlockAction) cancelBlock {
    
    return [[self alloc] initWithTitle:title
                     cancelButtonTitle:cancelButtonTitle
                destructiveButtonTitle:destructiveButtonTitle
                     otherButtonTitles:otherButtonTitles
                          dismissBlock:dismissBlock
                      destructiveBlock:destructiveBlock
                           cancelBlock:cancelBlock];
}

- (instancetype)initWithTitle:(NSString*) title
            cancelButtonTitle:(NSString*) cancelButtonTitle
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
            otherButtonTitles:(NSArray*) otherButtonTitles
                 dismissBlock:(DismissBlockAction) dismissBlock
             destructiveBlock:(DestructiveBlockAction) destructiveBlock
                  cancelBlock:(CancelBlockAction) cancelBlock {
    
    if (self = [super initWithTitle:title
                           delegate:self
                  cancelButtonTitle:nil
             destructiveButtonTitle:destructiveButtonTitle
                  otherButtonTitles:nil, nil]) {
        
        if (otherButtonTitles) {
            for (NSString *buttonTitle in otherButtonTitles) {
                [self addButtonWithTitle:buttonTitle];
            }
        }
        
        // Cancel
        if (cancelButtonTitle && otherButtonTitles) {
            [self addButtonWithTitle:cancelButtonTitle];
            self.cancelButtonIndex = otherButtonTitles.count;
        }
        if (destructiveButtonTitle) {
            self.cancelButtonIndex++;
        }
        
        
        if (dismissBlock) {
            _dismissBlock = dismissBlock;
        }
        
        if (cancelBlock) {
            _cancelBlock = cancelBlock;
        }
        
        if (destructiveBlock) {
            _destructiveBlock = destructiveBlock;
        }

    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString*) title
            cancelButtonTitle:(NSString*) cancelButtonTitle
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                 dismissBlock:(DismissBlockAction) dismissBlock
             destructiveBlock:(DestructiveBlockAction) destructiveBlock
                  cancelBlock:(CancelBlockAction) cancelBlock
            otherButtonTitles:(NSString*) otherButtonTitles, ... {
    
    if (self = [super initWithTitle:title
                           delegate:self
                  cancelButtonTitle:nil
             destructiveButtonTitle:destructiveButtonTitle
                  otherButtonTitles:nil, nil]) {
        
        NSInteger count = 0;
        if (otherButtonTitles) {
            
            [self addButtonWithTitle:otherButtonTitles];
            count++;
            
            va_list args;
            va_start(args, otherButtonTitles);
            
            NSString * title = nil;
            while((title = va_arg(args, NSString*))) {
                [self addButtonWithTitle:title];
                count++;
            }
            
            va_end(args);
        }
        
        // Cancel
        if (cancelButtonTitle && otherButtonTitles) {
            [self addButtonWithTitle:cancelButtonTitle];
            self.cancelButtonIndex = count;
        }
        if (destructiveButtonTitle) {
            self.cancelButtonIndex++;
        }
        
        
        if (dismissBlock) {
            _dismissBlock = dismissBlock;
        }
        
        if (cancelBlock) {
            _cancelBlock = cancelBlock;
        }
        
        if (destructiveBlock) {
            _destructiveBlock = destructiveBlock;
        }
        
    }
    
    return self;
}

#pragma mark - Action
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        if (_cancelBlock) {
            _cancelBlock();
        }
    }
    else if (buttonIndex == actionSheet.destructiveButtonIndex) {
        if (_destructiveBlock) {
            _destructiveBlock();
        }
    }
    else {
        if (_dismissBlock) {
            if (actionSheet.destructiveButtonIndex != -1) {
                _dismissBlock(buttonIndex - 1);// destructive button is button 0
            }
            else {
                _dismissBlock(buttonIndex);
            }
        }
    }
}

@end
