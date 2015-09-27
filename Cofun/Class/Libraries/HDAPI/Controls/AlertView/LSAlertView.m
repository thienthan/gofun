//
//  LSAlertView.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "LSAlertView.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

static NSString * const kCancelTitle  = @"Cancel";

@interface LSAlertView()<UIAlertViewDelegate>{
    
    DismissBlockAlert _dismissBlock;
    CancelBlockAlert _cancelBlock;
    
    NSString *_fontName;
    UIColor *_fontColor;
    UIColor *_fontShadowColor;
}

@end

@implementation LSAlertView

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

+ (instancetype)alertViewWithTitle:(NSString*) title
                           message:(NSString*) message {
    
    return [self alertViewWithTitle:title
                            message:message
                  cancelButtonTitle:kCancelTitle];
}

+ (instancetype)alertViewWithTitle:(NSString*) title
                           message:(NSString*) message
                 cancelButtonTitle:(NSString*) cancelButtonTitle {
    
    return [[self alloc] initWithTitle:title
                               message:[message stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]
                              delegate:nil
                     cancelButtonTitle:cancelButtonTitle
                     otherButtonTitles:nil, nil];
    
}

+ (instancetype)alertViewWithTitle:(NSString*) title
                           message:(NSString*) message
                 cancelButtonTitle:(NSString*) cancelButtonTitle
                 otherButtonTitles:(NSArray*) otherButtonTitles
                      dismissBlock:(DismissBlockAlert) dismissBlock
                       cancelBlock:(CancelBlockAlert) cancelBlock {
    
    return [[self alloc] initWithTitle:title
                               message:message
                     cancelButtonTitle:cancelButtonTitle
                     otherButtonTitles:otherButtonTitles
                          dismissBlock:dismissBlock
                           cancelBlock:cancelBlock];
    
    
}

- (instancetype)initWithTitle:(NSString*) title
                      message:(NSString*) message
            cancelButtonTitle:(NSString*) cancelButtonTitle
            otherButtonTitles:(NSArray*) otherButtonTitles
                 dismissBlock:(DismissBlockAlert) dismissBlock
                  cancelBlock:(CancelBlockAlert) cancelBlock {
    
    if (self = [super initWithTitle:title
                            message:[message stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]
                           delegate:self
                  cancelButtonTitle:cancelButtonTitle
                  otherButtonTitles:nil, nil]) {
        
        if (otherButtonTitles) {
            for (NSString *buttonTitle in otherButtonTitles) {
                [self addButtonWithTitle:buttonTitle];
            }
        }
        
        if (dismissBlock) {
            _dismissBlock = dismissBlock;
        }
        
        if (cancelBlock) {
            _cancelBlock = cancelBlock;
        }
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString*) title
                      message:(NSString*) message
            cancelButtonTitle:(NSString*) cancelButtonTitle
                 dismissBlock:(DismissBlockAlert) dismissBlock
                  cancelBlock:(CancelBlockAlert) cancelBlock
            otherButtonTitles:(NSString*) otherButtonTitles, ... {
    
    if (self = [super initWithTitle:title
                            message:[message stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]
                           delegate:self
                  cancelButtonTitle:cancelButtonTitle
                  otherButtonTitles:nil, nil]) {
        
        if (otherButtonTitles) {
            
            [self addButtonWithTitle:otherButtonTitles];
            
            va_list args;
            va_start(args, otherButtonTitles);
            
            NSString * title = nil;
            while((title = va_arg(args, NSString*))) {
                [self addButtonWithTitle:title];
            }
            
            va_end(args);
        }
        
        if (dismissBlock) {
            _dismissBlock = dismissBlock;
        }
        
        if (cancelBlock) {
            _cancelBlock = cancelBlock;
        }
    }
    
    return self;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews
{
    if (_fontName || _fontColor || _fontShadowColor) {
        for (UIView *subview in self.subviews){
            
            if ([subview isMemberOfClass:[UILabel class]]) {
                UILabel *label = (UILabel*)subview;
                label.numberOfLines = 0;//
                label.textColor = _fontColor ? _fontColor : label.textColor;
                label.shadowColor = _fontShadowColor ? _fontShadowColor : label.shadowColor;
                label.shadowOffset = CGSizeMake(0.0f, 1.0f);
                label.font = [UIFont fontWithName:_fontName?_fontName:label.font.fontName size:label.font.pointSize];
            }
            
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)subview;
                button.titleLabel.font = [UIFont fontWithName:_fontName ? _fontName:button.titleLabel.font.fontName size:button.titleLabel.font.pointSize];
                button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
                [button setTitleShadowColor:_fontShadowColor ? _fontShadowColor : button.titleLabel.shadowColor forState:UIControlStateNormal];
                [button setTitleColor:_fontColor ? _fontColor : button.titleLabel.textColor forState:UIControlStateNormal];
            }
        }
    }
}

#pragma mark - Setter
- (void)setFontName:(NSString*)fontName fontColor:(UIColor*)fontColor fontShadowColor:(UIColor*)fontShadowColor {
    
    _fontName = fontName;
    _fontColor = fontColor;
    _fontShadowColor = fontShadowColor;
}

#pragma mark - Action
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == alertView.cancelButtonIndex) {
        if (_cancelBlock) {
            _cancelBlock();
        }
    }
    else {
        if (_dismissBlock) {
            _dismissBlock(buttonIndex - 1);// cancel button is button 0
        }
    }
}

@end
