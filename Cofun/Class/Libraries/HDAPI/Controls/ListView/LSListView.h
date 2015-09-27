//
//  LSListView.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissBlockList)(NSInteger selectedIndex, NSString *selectedText);
typedef void (^DismissBlockLists)(NSMutableArray *selectedIndexs, NSMutableArray *selectedTexts);
typedef void (^CancelBlockList)();

@interface LSListView : UIView

+ (instancetype)listViewWithTitle:(NSString*) title
                       dataSource:(NSArray*) dataSource
                         selected:(id) selected
                     dismissBlock:(DismissBlockList) dismissBlock
                      cancelBlock:(CancelBlockList) cancelBlock;

- (instancetype)initWithTitle:(NSString*) title
                   dataSource:(NSArray*) dataSource
                     selected:(id) selected
                 dismissBlock:(DismissBlockList) dismissBlock
                  cancelBlock:(CancelBlockList) cancelBlock;

+ (instancetype)listViewWithTitles:(NSString*) title
                        dataSource:(NSArray*) dataSource
                          selected:(NSArray*) selected
                      dismissBlock:(DismissBlockLists) dismissBlock
                       cancelBlock:(CancelBlockList) cancelBlock;

- (instancetype)initWithTitles:(NSString*) title
                    dataSource:(NSArray*) dataSource
                      selected:(NSArray*) selected
                  dismissBlock:(DismissBlockLists) dismissBlock
                   cancelBlock:(CancelBlockList) cancelBlock;

- (void)show;
- (void)showWithCustomStyle:(BOOL)style;
- (void)dismiss;

@end
