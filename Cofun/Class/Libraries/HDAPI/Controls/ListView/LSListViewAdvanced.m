//
//  LSListViewAdvanced.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "LSListViewAdvanced.h"
#import "NSObject+Extensions.h"
#import "LSMacro.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

static float const kStatusBarHeight                 = 20.f;

static CGFloat const kLeftMargin            = 10.0f;
static CGFloat const kTopMargin             = 10.0f;
static CGFloat const kRadius                = 10.0f;

static CGFloat const kActionHeight          = 45.0f;
static CGFloat const kRowHeight             = 45.0f;
static CGFloat const kLineHeight            = 1.0f;
static CGFloat const kTitleHeight           = 45.0f;

static CGFloat const kTitleFontSize         = 15.0f;
static CGFloat const kActionFontSize        = 17.0f;
static CGFloat const kInputFontSize         = 15.0f;

static NSString * const kCenterActionText   = @"Close";
static NSString * const kLeftActionText     = @"Cancel";
static NSString * const kRightActionText    = @"OK";
static NSString * const kTitleDefault       = @"List";

static NSInteger const kActionLeftTag       = 2001;
static NSInteger const kActionRightTag      = 2002;

static BOOL const kViewStylePhone           = YES;
static CGFloat const kPhoneWidth            = 320.0f;

#define FULL_SCREEN_COLOR       [UIColor colorWithRed:(0)/255.0f green:(0)/255.0f blue:(0)/255.0f alpha:0.4f]
#define VIEW_COLOR              [UIColor colorWithRed:(240)/255.0f green:(240)/255.0f blue:(240)/255.0f alpha:1.0f]
#define LINE_COLOR              [UIColor colorWithRed:(200)/255.0f green:(200)/255.0f blue:(200)/255.0f alpha:1.0f]
#define ACTION_TITLE_COLOR      [UIColor colorWithRed:(0)/255.0f green:(122)/255.0f blue:(255)/255.0f alpha:1.0f]
#define ACTION_HEIGHLIGHT_COLOR [UIColor colorWithRed:(220)/255.0f green:(220)/255.0f blue:(220)/255.0f alpha:1.0f]
#define TABLE_VIEW_COLOR        [UIColor colorWithRed:(249)/255.0f green:(249)/255.0f blue:(249)/255.0f alpha:1.0f]
#define TITLE_COLOR             [UIColor colorWithRed:(0)/255.0f green:(122)/255.0f blue:(255)/255.0f alpha:1.0f]

@interface LSListViewAdvanced()<UITableViewDataSource, UITableViewDelegate> {
    
    DismissBlockListsAdv _dismissBlocks;
    CancelBlockListAdv _cancelBlock;
    
    NSMutableArray *_dataSource;
    NSString *_textKey;
    NSString *_selectedKey;
    
    BOOL _customStyle;
    
    BOOL _isValid;
}

@end

@implementation LSListViewAdvanced

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

+ (instancetype)listViewWithTitles:(NSString*) title
                        dataSource:(NSArray*) dataSource
                           textKey:(NSString*) textKey
                       selectedKey:(NSString*) selectedKey
                      dismissBlock:(DismissBlockListsAdv) dismissBlock
                       cancelBlock:(CancelBlockListAdv) cancelBlock {
    
    return [[self alloc] initWithTitles:title
                             dataSource:dataSource
                                textKey:textKey
                            selectedKey:selectedKey
                           dismissBlock:dismissBlock
                            cancelBlock:cancelBlock];
}

- (instancetype)initWithTitles:(NSString*) title
                    dataSource:(NSArray*) dataSource
                       textKey:(NSString*) textKey
                   selectedKey:(NSString*) selectedKey
                  dismissBlock:(DismissBlockListsAdv) dismissBlock
                   cancelBlock:(CancelBlockListAdv) cancelBlock {
    
    CGRect screenBound = SCREEN_FRAME;
    if (self = [super initWithFrame:screenBound]) {
        
        // Full Screen View
        [self setBackgroundColor:FULL_SCREEN_COLOR];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        BOOL isValid = NO;
        if (dataSource != nil) {
            if (dataSource.count > 0 && [NSObject isNullOrEmpty:textKey] == NO && [NSObject isNullOrEmpty:selectedKey] == NO) {
                isValid = YES;
            }
        }
        _isValid = isValid;
        
        if (isValid) {
            // << View
            
            CGFloat topMargin = 0;
            NSInteger row = dataSource.count;
            NSInteger maxRow = 0;
            CGFloat maxHeight = screenBound.size.height - kStatusBarHeight - (2*kTopMargin) - kActionHeight - kTitleHeight;
            maxRow = floorf(maxHeight / kRowHeight);
            
            BOOL scrollEnabled = NO;
            if (row > maxRow) {
                row = maxRow;
                scrollEnabled = YES;
            }
            CGFloat viewHeight = (kRowHeight * row) + kActionHeight + kTitleHeight;
            topMargin = roundf((screenBound.size.height - kStatusBarHeight - viewHeight) / 2);
            
            CGFloat viewWidth = screenBound.size.width - (2*kLeftMargin);
            CGFloat viewX = kLeftMargin;
            if (kViewStylePhone && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                viewWidth = kPhoneWidth - (2*kLeftMargin);
                viewX = roundf((screenBound.size.width - viewWidth) / 2.0f);
            }
            
            CGRect viewFrame;
            if (SYSTEM_VERSION_VALUE < 7.0f) {
                viewFrame = CGRectMake(viewX, topMargin, viewWidth, viewHeight);
            }
            else {
                viewFrame = CGRectMake(viewX, kStatusBarHeight + topMargin, viewWidth, viewHeight);
            }
            
            UIView *view = [[UIView alloc] initWithFrame:viewFrame];
            [view setTag:1000];
            [view setBackgroundColor:[UIColor clearColor]];
            VIEW_RADIUS(view, kRadius);
            [self addSubview:view];
            
            viewFrame.origin.x = 0;
            viewFrame.origin.y = 0;
            UIView *view1 = [[UIView alloc] initWithFrame:viewFrame];
            [view1 setBackgroundColor:VIEW_COLOR];
            VIEW_RADIUS(view1, kRadius);
            [view1 setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
            [view addSubview:view1];
            
            // << Content View
            CGRect contentViewFrame = CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height - kActionHeight);
            UIView *contentView = [[UIView alloc] initWithFrame:contentViewFrame];
            [contentView setBackgroundColor:[UIColor clearColor]];
            [view1 addSubview:contentView];
            
            // Title
            CGRect titleFrame = CGRectMake(kLeftMargin, 0, contentViewFrame.size.width - (2*kLeftMargin), kTitleHeight);
            UILabel *lbTitle = [[UILabel alloc] initWithFrame:titleFrame];
            [lbTitle setFont:[UIFont systemFontOfSize:kTitleFontSize]];
            [lbTitle setTextColor:TITLE_COLOR];
            [lbTitle setNumberOfLines:0];
            [lbTitle setLineBreakMode:NSLineBreakByWordWrapping];
            [lbTitle setMinimumScaleFactor:0.5];
            [lbTitle setAdjustsFontSizeToFitWidth:YES];
            [lbTitle setTextAlignment:NSTextAlignmentLeft];
            [lbTitle setBackgroundColor:[UIColor clearColor]];
            if (title) {
                [lbTitle setText:title];
            }
            else {
                [lbTitle setText:kTitleDefault];
            }
            [contentView addSubview:lbTitle];
            
            // Table View
            CGRect tableFrame = CGRectMake(0, titleFrame.origin.y + titleFrame.size.height, contentViewFrame.size.width, contentViewFrame.size.height - (titleFrame.origin.y + titleFrame.size.height));
            UITableView *tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
            [tableView setBackgroundColor:TABLE_VIEW_COLOR];
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            tableView.scrollEnabled = scrollEnabled;
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.rowHeight = kRowHeight;
            [contentView addSubview:tableView];
            
            // Content View >>
            
            
            // << Action View
            CGRect actionViewFrame = CGRectMake(0, contentViewFrame.origin.y + contentViewFrame.size.height - 1, viewFrame.size.width, kActionHeight + 1);
            UIView *actionView = [[UIView alloc] initWithFrame:actionViewFrame];
            [actionView setBackgroundColor:[UIColor clearColor]];
            [view1 addSubview:actionView];
            
            // Action
            UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnLeft setFrame:CGRectMake(0, kLineHeight, roundf(actionViewFrame.size.width / 2), kActionHeight - kLineHeight + 1)];
            [btnLeft setExclusiveTouch:YES];
            [btnLeft.titleLabel setFont:[UIFont systemFontOfSize:kActionFontSize]];
            [btnLeft setTitleColor:ACTION_TITLE_COLOR forState:UIControlStateNormal];
            [btnLeft setBackgroundImage:[self imageWithColor:ACTION_HEIGHLIGHT_COLOR size:btnLeft.frame.size] forState:UIControlStateHighlighted];
            [btnLeft setTitle:kLeftActionText forState:UIControlStateNormal];
            btnLeft.titleLabel.minimumScaleFactor = 0.5;
            btnLeft.titleLabel.textAlignment = NSTextAlignmentCenter;
            btnLeft.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            [btnLeft setTag:kActionLeftTag];
            [btnLeft addTarget:self action:@selector(btnLeftTapped:) forControlEvents:UIControlEventTouchUpInside];
            [actionView addSubview:btnLeft];
            
            UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnRight setFrame:CGRectMake(roundf(actionViewFrame.size.width / 2), kLineHeight, roundf(actionViewFrame.size.width / 2), kActionHeight - kLineHeight + 1)];
            [btnRight setExclusiveTouch:YES];
            [btnRight.titleLabel setFont:[UIFont boldSystemFontOfSize:kActionFontSize]];
            [btnRight setTitleColor:ACTION_TITLE_COLOR forState:UIControlStateNormal];
            [btnRight setBackgroundImage:[self imageWithColor:ACTION_HEIGHLIGHT_COLOR size:btnLeft.frame.size] forState:UIControlStateHighlighted];
            [btnRight setTitle:kRightActionText forState:UIControlStateNormal];
            btnRight.titleLabel.minimumScaleFactor = 0.5;
            btnRight.titleLabel.textAlignment = NSTextAlignmentCenter;
            btnRight.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            [btnRight setTag:kActionRightTag];
            [btnRight addTarget:self action:@selector(btnRightTapped:) forControlEvents:UIControlEventTouchUpInside];
            [actionView addSubview:btnRight];
            
            // Line
            UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, actionViewFrame.size.width, kLineHeight)];
            [hView setBackgroundColor:LINE_COLOR];
            [actionView addSubview:hView];
            
            UIView *vView = [[UIView alloc] initWithFrame:CGRectMake(roundf(actionViewFrame.size.width / 2), 0, kLineHeight, kActionHeight + 1)];
            [vView setBackgroundColor:LINE_COLOR];
            [actionView addSubview:vView];
            
            // Action View >>
            
            // View >>
            
            if (dismissBlock) {
                _dismissBlocks = dismissBlock;
            }
            
            if (cancelBlock) {
                _cancelBlock = cancelBlock;
            }
            
            if (dataSource) {
                _dataSource = [NSMutableArray arrayWithArray:dataSource];
            }
            
            if (textKey) {
                _textKey = textKey;
            }
            
            if (selectedKey) {
                _selectedKey = selectedKey;
            }
        }
    }
    
    return self;
}

#pragma mark - Private method
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)tableView:(UITableView*)tableView tappedAtIndex:(NSIndexPath*)indexPath {
    
    // update array
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[_dataSource objectAtIndex:indexPath.row]];
    
    if (dict) {
        
        BOOL selected = [[dict objectForKey:_selectedKey] boolValue];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (selected) {
            
            [dict setObject:[NSNumber numberWithBool:NO] forKey:_selectedKey];
            cell.accessoryType = UITableViewCellAccessoryNone;
            //[cell setSelected:NO animated:YES];
            
        }
        else {
            
            [dict setObject:[NSNumber numberWithBool:YES] forKey:_selectedKey];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            //[cell setSelected:YES animated:YES];
        }
        [_dataSource replaceObjectAtIndex:indexPath.row withObject:dict];
    }
}

#pragma mark - UITableViewDataSource + UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = kRowHeight;
    
    NSDictionary *dict = [_dataSource objectAtIndex:indexPath.row];
    if (dict) {
        
        NSString *text = [dict objectForKey:_textKey];
        if (![NSObject isNullOrEmpty:text]) {

            CGSize size = CGSizeZero;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
            size = [text sizeWithFont:[UIFont systemFontOfSize:kInputFontSize]
                    constrainedToSize:tableView.bounds.size
                        lineBreakMode:NSLineBreakByWordWrapping];
#else
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:kInputFontSize], NSFontAttributeName,
                                        [NSParagraphStyle defaultParagraphStyle], NSParagraphStyleAttributeName,
                                        nil];
            size = [text boundingRectWithSize:tableView.bounds.size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                   attributes:attributes
                                      context:nil].size;
#endif
            
            if (size.height > rowHeight) {
                rowHeight = size.height;
            }
        }
    }
    
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setBackgroundColor:TABLE_VIEW_COLOR];
    [cell.textLabel setFont:[UIFont systemFontOfSize:kInputFontSize]];
    [cell.textLabel setTextColor:ACTION_TITLE_COLOR];
    [cell.textLabel setNumberOfLines:0];
    
    NSDictionary *dict = [_dataSource objectAtIndex:indexPath.row];
    if (dict) {
        
        NSString *text = [dict objectForKey:_textKey];
        if (![NSObject isNullOrEmpty:text]) {
            cell.textLabel.text = text;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL selected = NO;
    
    NSDictionary *dict = [_dataSource objectAtIndex:indexPath.row];
    if (dict) {
        
        selected = [[dict objectForKey:_selectedKey] boolValue];
    }
    
    if (selected == NO) {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        //[cell setSelected:NO animated:YES];
        
    }
    else {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //[cell setSelected:YES animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // animation when select
    //NSArray *paths = [NSArray arrayWithObject:indexPath];
    //[tableView reloadRowsAtIndexPaths:paths withRowAnimation:NO];
    
    [self tableView:tableView tappedAtIndex:indexPath];
}


#pragma mark - Action
- (void)btnLeftTapped:(id)sender {
    
    if (_cancelBlock) {
        _cancelBlock();
    }
    [self dismiss];
}

- (void)btnRightTapped:(id)sender {
    
    if (_dismissBlocks) {
        
        _dismissBlocks(_dataSource);
    }
    [self dismiss];
}

#pragma mark - Show + Dismiss
- (void)showView {
    
    if (_customStyle == NO) {
        UIView *view = (UIView *)[self viewWithTag:1000];
        view.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.alpha = 0;
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if(!keyWindow)
        {
            NSArray *windows = [UIApplication sharedApplication].windows;
            keyWindow = [windows objectAtIndex:0];
        }
        UIView *containerView = [[keyWindow subviews] objectAtIndex:0];
        [containerView endEditing:YES];
        //UIView *containerView = [[[UIApplication sharedApplication] windows] lastObject];
        [containerView addSubview:self];
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.alpha = 1;
            view.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished){
            
            
        }];
    }
    else {
        UIView *view = (UIView *)[self viewWithTag:1000];
        CGRect frame = view.frame;
        
        CGRect temp = frame;
        temp.size.height = 0;
        view.frame = temp;
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if(!keyWindow)
        {
            NSArray *windows = [UIApplication sharedApplication].windows;
            keyWindow = [windows objectAtIndex:0];
        }
        UIView *containerView = [[keyWindow subviews] objectAtIndex:0];
        [containerView endEditing:YES];
        //UIView *containerView = [[[UIApplication sharedApplication] windows] lastObject];
        [containerView addSubview:self];
        
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            view.frame = frame;
            
        } completion:^(BOOL finished){
            
        }];
    }
}

- (void)show {
    if (_isValid) {
        [self performSelector:@selector(showView) withObject:nil afterDelay:0.1];
    }
}

- (void)showWithCustomStyle:(BOOL)style {
    
    _customStyle = style;
    [self show];
}

- (void)dismiss {
    
    if (_isValid) {
        if (_customStyle == NO) {
            UIView *view = (UIView *)[self viewWithTag:1000];
            [view endEditing:YES];
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.alpha = 0;
                view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                
            } completion:^(BOOL finished){
                
                [self removeFromSuperview];
            }];
        }
        else {
            UIView *view = (UIView *)[self viewWithTag:1000];
            CGRect frame = view.frame;
            frame.size.height = 0;
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                view.frame = frame;
                
            } completion:^(BOOL finished){
                
                [self removeFromSuperview];
            }];
        }
    }
}

@end
