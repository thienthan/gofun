//
//  LSListViewAdvanced.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissBlockListsAdv)(NSMutableArray *array);
typedef void (^CancelBlockListAdv)();

@interface LSListViewAdvanced : UIView

+ (instancetype)listViewWithTitles:(NSString*) title
                        dataSource:(NSArray*) dataSource
                           textKey:(NSString*) textKey
                       selectedKey:(NSString*) selectedKey
                      dismissBlock:(DismissBlockListsAdv) dismissBlock
                       cancelBlock:(CancelBlockListAdv) cancelBlock;

- (instancetype)initWithTitles:(NSString*) title
                    dataSource:(NSArray*) dataSource
                       textKey:(NSString*) textKey
                   selectedKey:(NSString*) selectedKey
                  dismissBlock:(DismissBlockListsAdv) dismissBlock
                   cancelBlock:(CancelBlockListAdv) cancelBlock;

- (void)show;
- (void)showWithCustomStyle:(BOOL)style;
- (void)dismiss;

@end
