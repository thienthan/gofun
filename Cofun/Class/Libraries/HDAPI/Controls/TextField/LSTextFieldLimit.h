//
//  LSTextFieldLimit.h
//  FlimFlam
//
//  Created by Son HD on 10/10/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSTextFieldLimit : UITextField
@property (nonatomic, weak) IBOutlet id<UITextFieldDelegate> textFieldDelagate;
@property (nonatomic) NSInteger limit;
@property (nonatomic) BOOL isDigit;
@end
