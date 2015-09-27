//
//  LSTextFieldLimit.m
//  FlimFlam
//
//  Created by Son HD on 10/10/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import "LSTextFieldLimit.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

static int const kDefaultInputLength = 100;

@interface LSTextFieldLimit()<UITextFieldDelegate>
@property (nonatomic) UIEdgeInsets edgeInsets;
@property (nonatomic) NSInteger edgeInsetLeft;
@property (nonatomic) NSInteger edgeInsetRight;
@end

@implementation LSTextFieldLimit

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

// awakeFromNib gets called after the view and its subviews were allocated and initialized. It is guaranteed that the view will have all its outlet instance variables set. At this point all the outlets will have been set.
- (void)awakeFromNib {
    // Initialization code
    [self initialize];
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
    self.edgeInsetLeft = 5.0f;
    self.edgeInsetRight = 5.0f;
    self.edgeInsets = UIEdgeInsetsMake(0.0f, self.edgeInsetLeft, 0.0f, self.edgeInsetRight);
    
    self.delegate = self;
    if (self.limit == 0) {
        self.limit = kDefaultInputLength;
    }
}

#pragma mark - Padding
- (CGRect)textRectForBounds:(CGRect)bounds {
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

#pragma mark - Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.textFieldDelagate && [self.textFieldDelagate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.textFieldDelagate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.textFieldDelagate && [self.textFieldDelagate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.textFieldDelagate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.textFieldDelagate && [self.textFieldDelagate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.textFieldDelagate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.textFieldDelagate && [self.textFieldDelagate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.textFieldDelagate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.isDigit) {
        if (string.length > 1) {
            return NO;
        }
        if (![string isEqualToString:@""]) {
            int asciiCode = [string characterAtIndex:0];
            if (!(asciiCode >= 48 && asciiCode <= 57)) {
                return NO;
            }
        }
    }
    
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (newLength > self.limit) {
        return NO;
    }
    
    if (self.textFieldDelagate && [self.textFieldDelagate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.textFieldDelagate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (self.textFieldDelagate && [self.textFieldDelagate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.textFieldDelagate textFieldShouldClear:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.textFieldDelagate && [self.textFieldDelagate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.textFieldDelagate textFieldShouldReturn:textField];
    }
    return YES;
}

@end
