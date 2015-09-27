//
//  LSDropDownListView.m
//  DropDownDemo
//
//  Created by SonHD on 10/23/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import "LSDropDownListView.h"
#import "LSDropDownViewCell.h"

#define DROPDOWNVIEW_SCREENINSET 0
#define DROPDOWNVIEW_HEADER_HEIGHT 50.0f
#define DROPDOWNVIEW_ROW_HEIGHT 44.0f
#define RADIUS 0

#define FontName @"HelveticaNeue"

@interface LSDropDownListView() <UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_tableView;
    NSString *_titleText;
    NSArray *_options;
    CGFloat _R, _G, _B, _A;
    BOOL _isMultipleSelection;
    NSMutableArray *_selectedOptions;
}
@end

@implementation LSDropDownListView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title options:(NSArray *)options selectedOptions:(NSArray *)selectedOptions origin:(CGPoint)origin size:(CGSize)size isMultiple:(BOOL)isMultiple {
    
    _isMultipleSelection = isMultiple;
    
    CGRect rect = CGRectMake(origin.x, origin.y, size.width, size.height);
    CGFloat tableHeight = rect.size.height - 2 * DROPDOWNVIEW_SCREENINSET - DROPDOWNVIEW_HEADER_HEIGHT - RADIUS;
    
    CGFloat realTableHeight = options.count * DROPDOWNVIEW_ROW_HEIGHT;
    if (realTableHeight < tableHeight) {
        rect.size.height = rect.size.height - (tableHeight - realTableHeight);
        tableHeight = realTableHeight;
    }
    
    if (self = [super initWithFrame:rect])
    {
        self.backgroundColor = [UIColor clearColor];
        _titleText = [title copy];
        _options = [options copy];
        
        if (_isMultipleSelection) {
            _selectedOptions = [[NSMutableArray alloc]init];
            if (selectedOptions) {
                for (int i = 0; i < selectedOptions.count; i++) {
                    if ([_options containsObject:[selectedOptions objectAtIndex:i]]) {
                        [_selectedOptions addObject:[NSNumber numberWithInteger:[_options indexOfObject:[selectedOptions objectAtIndex:i]]]];
                    }
                }
            }
        }
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(DROPDOWNVIEW_SCREENINSET,
                                                                    DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT,
                                                                    rect.size.width - 2 * DROPDOWNVIEW_SCREENINSET,
                                                                    tableHeight)];
        
        _tableView.separatorColor = [UIColor colorWithWhite:1 alpha:.2];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.rowHeight = DROPDOWNVIEW_ROW_HEIGHT;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        
        if (_isMultipleSelection) {
            UIButton *btnDone=[UIButton  buttonWithType:UIButtonTypeCustom];
            //[btnDone setFrame:CGRectMake(rect.origin.x+182,rect.origin.y-45, 82, 31)];
            [btnDone setFrame:CGRectMake(rect.size.width - 80 - 10, 10, 80, 30)];
            NSBundle* bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle]URLForResource:@"LSDropDownListView" withExtension:@"bundle"]];
            NSString *imagePath = [bundle pathForResource:@"done@2x" ofType:@"png"];
            [btnDone setImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
            [btnDone addTarget:self action:@selector(btnDoneTapped:) forControlEvents: UIControlEventTouchUpInside];
            [self addSubview:btnDone];
        }
    }
    return self;
}

- (void)btnDoneTapped:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownListView:selectedOptions:)]) {
        
        NSLog(@"%@",_selectedOptions);
        NSMutableArray *responseArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < _selectedOptions.count; i++) {
            
            NSNumber *number = [_selectedOptions objectAtIndex:i];
            [responseArray addObject:[_options objectAtIndex:[number integerValue]]];
            NSLog(@"pathRow=%ld",(long)[number integerValue]);
        }
        
        [_delegate dropDownListView:self selectedOptions:responseArray];
    }
    // dismiss self
    [self fadeOut];
}

#pragma mark - Private Methods
- (void)fadeIn {
    
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

- (void)fadeOut {
    
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated {
    
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

#pragma mark - Tableview datasource & delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"LSDropDownViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
    }
    cell = [[LSDropDownViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if (_isMultipleSelection) {
        UIImageView *imgarrow = [[UIImageView alloc] init];
        
        if([_selectedOptions containsObject:[NSNumber numberWithInteger:indexPath.row]]){
            imgarrow.frame = CGRectMake(tableView.frame.size.width - 20 - 15, (tableView.rowHeight - 20)/2, 20, 20);
            NSBundle* bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle]URLForResource:@"LSDropDownListView" withExtension:@"bundle"]];
            NSString *imagePath = [bundle pathForResource:@"check_mark@2x" ofType:@"png"];
            imgarrow.image = [UIImage imageWithContentsOfFile:imagePath];
            //imgarrow.image = [UIImage imageNamed:@"LSDropDownListView.bundle/wheel-check_mark@2x.png"];
        } else {
            imgarrow.image = nil;
        }
        
        [cell addSubview:imgarrow];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_options objectAtIndex:indexPath.row] ;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isMultipleSelection) {
        if([_selectedOptions containsObject:[NSNumber numberWithInteger:indexPath.row]]){
            [_selectedOptions removeObject:[NSNumber numberWithInteger:indexPath.row]];
        } else {
            [_selectedOptions addObject:[NSNumber numberWithInteger:indexPath.row]];
        }
        [tableView reloadData];
    }
    else{
        
        if (_delegate && [_delegate respondsToSelector:@selector(dropDownListView:didSelectedAtIndex:)]) {
            [_delegate dropDownListView:self didSelectedAtIndex:[indexPath row]];
        }
        // dismiss self
        [self fadeOut];
    }
}

#pragma mark - Touch
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // tell the delegate the cancellation
    
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownListViewDidCancel)]) {
        [_delegate dropDownListViewDidCancel];
    }
    // dismiss self
    [self fadeOut];
}

#pragma mark - Draw
- (void)drawRect:(CGRect)rect
{
    CGRect bgRect = CGRectInset(rect, DROPDOWNVIEW_SCREENINSET, DROPDOWNVIEW_SCREENINSET);
    CGRect titleRect = CGRectMake(DROPDOWNVIEW_SCREENINSET + 10, DROPDOWNVIEW_SCREENINSET + 10 + 5,
                                  rect.size.width -  2 * (DROPDOWNVIEW_SCREENINSET + 10), 30);
    CGRect separatorRect = CGRectMake(DROPDOWNVIEW_SCREENINSET, DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT - 2,
                                      rect.size.width - 2 * DROPDOWNVIEW_SCREENINSET, 2);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Draw the background with shadow
    // Draw the background with shadow
    CGContextSetShadowWithColor(ctx, CGSizeZero, 6., [UIColor colorWithWhite:0 alpha:1.0].CGColor);
    [[UIColor colorWithRed:_R/255 green:_G/255 blue:_B/255 alpha:_A] setFill];
    
    float x = DROPDOWNVIEW_SCREENINSET;
    float y = DROPDOWNVIEW_SCREENINSET;
    float width = bgRect.size.width;
    float height = bgRect.size.height;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, x, y + RADIUS);
    CGPathAddArcToPoint(path, NULL, x, y, x + RADIUS, y, RADIUS);
    CGPathAddArcToPoint(path, NULL, x + width, y, x + width, y + RADIUS, RADIUS);
    CGPathAddArcToPoint(path, NULL, x + width, y + height, x + width - RADIUS, y + height, RADIUS);
    CGPathAddArcToPoint(path, NULL, x, y + height, x, y + height - RADIUS, RADIUS);
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    CGPathRelease(path);
    
    // Draw the title and the separator with shadow
    
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 0.5f, [UIColor blackColor].CGColor);
    [[UIColor colorWithWhite:1 alpha:1.] setFill];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    UIFont *font = [UIFont fontWithName:FontName size:16.0];
    UIColor *cl=[UIColor whiteColor];
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,NSForegroundColorAttributeName:cl};
    
    [_titleText drawInRect:titleRect withAttributes:attributes];
#else
    [_titleText drawInRect:titleRect withFont:[UIFont systemFontOfSize:16.]];
#endif
    
    CGContextFillRect(ctx, separatorRect);
}

- (void)setBackgroundDropDown_R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha {
    
    _R = r;
    _G = g;
    _B = b;
    _A = alpha;
}

@end