//
//  LSDropDownListView.h
//  DropDownDemo
//
//  Created by SonHD on 10/23/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSDropDownListViewlegate;
@interface LSDropDownListView : UIView

@property (nonatomic, weak) id<LSDropDownListViewlegate> delegate;

// The options is a NSArray, contain some NSDictionaries, the NSDictionary contain 2 keys, one is "img", another is "text".
- (id)initWithTitle:(NSString *)title options:(NSArray *)options selectedOptions:(NSArray *)selectedOptions origin:(CGPoint)origin size:(CGSize)size isMultiple:(BOOL)isMultiple;

- (void)setBackgroundDropDown_R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;

// If animated is YES, PopListView will be appeared with FadeIn effect.
- (void)showInView:(UIView *)aView animated:(BOOL)animated;

- (void)fadeOut;
@end

@protocol LSDropDownListViewlegate <NSObject>
@optional
- (void)dropDownListView:(LSDropDownListView *)dropdownListView didSelectedAtIndex:(NSInteger)index; // Single Selection
- (void)dropDownListView:(LSDropDownListView *)dropdownListView selectedOptions:(NSMutableArray*)selectedOptions; // Multiple Selection
- (void)dropDownListViewDidCancel;
@end

