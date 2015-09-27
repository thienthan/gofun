//
//  LSTextView.m
//  VIN API Project
//
//  Created by SonHD on 12/25/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "LSTextView.h"

#define IS_ARC              (__has_feature(objc_arc))


@interface LSTextView (PrivateMethods)
- (void)_updateShouldDrawPlaceholder;
- (void)_textChanged:(NSNotification *)notification;
@end


static int const kDefaultInputLength = 1000;

@interface LSTextView() <UITextViewDelegate>

@end

@implementation LSTextView

#pragma mark -
#pragma mark Accessors

@synthesize placeholder = _placeholder;
@synthesize placeholderColor = _placeholderColor;

- (void)setText:(NSString *)string {
	[super setText:string];
	[self _updateShouldDrawPlaceholder];
}


- (void)setPlaceholder:(NSString *)string {
	if ([string isEqual:_placeholder]) {
		return;
	}
	
#if IS_ARC
    _placeholder = string;
#else
	[_placeholder release];
	_placeholder = [string retain];
#endif
	
	[self _updateShouldDrawPlaceholder];
}


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
	
#if !IS_ARC
	[_placeholder release];
	[_placeholderColor release];
	[super dealloc];
#endif
}


#pragma mark -
#pragma mark UIView

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

- (void)awakeFromNib {
    // Initialization code
    [self initialize];
    _shouldDrawPlaceholder = self.placeholder && self.placeholderColor && self.text.length == 0;
}

- (void)initialize {
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textChanged:) name:UITextViewTextDidChangeNotification object:self];
    
    self.placeholderColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
    _shouldDrawPlaceholder = NO;
    
    if (self.limit == 0) {
        self.limit = kDefaultInputLength;
    }
}


- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	if (_shouldDrawPlaceholder) {
		[_placeholderColor set];
//		[_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, self.frame.size.height - 16.0f) withFont:self.font];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.font, NSFontAttributeName, _placeholderColor, NSForegroundColorAttributeName,
                                    nil];
        [_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, self.frame.size.height - 16.0f) withAttributes:attributes];
	}
}


#pragma mark -
#pragma mark Private Methods

- (void)_updateShouldDrawPlaceholder {
	BOOL prev = _shouldDrawPlaceholder;
	_shouldDrawPlaceholder = self.placeholder && self.placeholderColor && self.text.length == 0;
	
	if (prev != _shouldDrawPlaceholder) {
		[self setNeedsDisplay];
	}
}


- (void)_textChanged:(NSNotification *)notificaiton {
	[self _updateShouldDrawPlaceholder];
}

#pragma mark - Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (self.textViewDelagate && [self.textViewDelagate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        [self.textViewDelagate textViewShouldBeginEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (self.textViewDelagate && [self.textViewDelagate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        [self.textViewDelagate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.textViewDelagate && [self.textViewDelagate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.textViewDelagate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.textViewDelagate && [self.textViewDelagate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.textViewDelagate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSInteger textLength = text.length;
    NSRange resultRange = [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet] options:NSBackwardsSearch];
    if ([text length] == 1 && resultRange.location != NSNotFound) {
        textLength = 0;
    }
    
    NSUInteger newLength = [textView.text length] + textLength - range.length;
    if (newLength > self.limit) {
        return NO;
    }
    
    if (self.textViewDelagate && [self.textViewDelagate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.textViewDelagate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.textViewDelagate && [self.textViewDelagate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.textViewDelagate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if (self.textViewDelagate && [self.textViewDelagate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.textViewDelagate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if (self.textViewDelagate && [self.textViewDelagate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        [self.textViewDelagate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    if (self.textViewDelagate && [self.textViewDelagate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        [self.textViewDelagate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}

@end
