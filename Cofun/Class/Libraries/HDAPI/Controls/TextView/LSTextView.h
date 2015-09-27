//
//  LSTextView.h
//  VIN API Project
//
//  Created by SonHD on 12/25/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @brief UITextView subclass that adds placeholder support like
 UITextField has.
 */
@interface LSTextView : UITextView {
	
@private
	
	NSString *_placeholder;
	UIColor *_placeholderColor;
    
	BOOL _shouldDrawPlaceholder;
}

/**
 @brief The string that is displayed when there is no other text in the text view.
 
 The default value is nil.
 */
@property (nonatomic, retain) NSString *placeholder;

/**
 @brief The color of the placeholder.
 
 The default is [UIColor lightGrayColor].
 */
@property (nonatomic, retain) UIColor *placeholderColor;

/**
 The default is NO.
 */
@property (nonatomic,assign) BOOL isMandatory;


@property (nonatomic, weak) IBOutlet id<UITextViewDelegate> textViewDelagate;
@property (nonatomic) NSInteger limit;

@end
