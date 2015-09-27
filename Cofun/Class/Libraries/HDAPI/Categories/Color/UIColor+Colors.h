//
//  UIColor+Colors.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

// Color Scheme Creation Enum
typedef NS_ENUM(NSUInteger, ColorScheme) {
    ColorSchemeAnalagous,
    ColorSchemeMonochromatic,
    ColorSchemeTriad,
    ColorSchemeComplementary
};

@interface UIColor (Colors)

///-----------------------------------------------------------------
/// Color Methods
///-----------------------------------------------------------------
+ (instancetype)colorFromHexString:(NSString *)hexString;
+ (instancetype)colorWithHexNumber:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (instancetype)colorWithRGBAArray:(NSArray *)rgbaArray;
+ (instancetype)colorWithCMYK:(NSArray *)cmykValues;
- (NSString *)hexString;
- (NSArray *)rgbaArray;//returns the rgba as percents
- (NSArray *)rgbaValues;//returns rgba as actual rgb values
- (NSArray *)hsbaArray;
- (NSDictionary *)rgbaDict;
- (NSDictionary *)hsbaDict;


///-----------------------------------------------------------------
/// Generate Color Scheme
///-----------------------------------------------------------------
- (NSArray *)colorSchemeOfType:(ColorScheme)type;


///-----------------------------------------------------------------
/// System Colors
///-----------------------------------------------------------------
+ (instancetype)infoBlueColor;
+ (instancetype)successColor;
+ (instancetype)warningColor;
+ (instancetype)dangerColor;


///-----------------------------------------------------------------
/// Whites
///-----------------------------------------------------------------
+ (instancetype)antiqueWhiteColor;
+ (instancetype)oldLaceColor;
+ (instancetype)ivoryColor;
+ (instancetype)seashellColor;
+ (instancetype)ghostWhiteColor;
+ (instancetype)snowColor;
+ (instancetype)linenColor;


///-----------------------------------------------------------------
/// Grays
///-----------------------------------------------------------------
+ (instancetype)black25PercentColor;
+ (instancetype)black50PercentColor;
+ (instancetype)black75PercentColor;
+ (instancetype)warmGrayColor;
+ (instancetype)coolGrayColor;
+ (instancetype)charcoalColor;


///-----------------------------------------------------------------
/// Blues
///-----------------------------------------------------------------
+ (instancetype)tealColor;
+ (instancetype)steelBlueColor;
+ (instancetype)robinEggColor;
+ (instancetype)pastelBlueColor;
+ (instancetype)turquoiseColor;
+ (instancetype)skyeBlueColor;
+ (instancetype)indigoColor;
+ (instancetype)denimColor;
+ (instancetype)blueberryColor;
+ (instancetype)cornflowerColor;
+ (instancetype)babyBlueColor;
+ (instancetype)midnightBlueColor;
+ (instancetype)fadedBlueColor;
+ (instancetype)icebergColor;
+ (instancetype)waveColor;


///-----------------------------------------------------------------
/// Greens
///-----------------------------------------------------------------
+ (instancetype)emeraldColor;
+ (instancetype)grassColor;
+ (instancetype)pastelGreenColor;
+ (instancetype)seafoamColor;
+ (instancetype)paleGreenColor;
+ (instancetype)cactusGreenColor;
+ (instancetype)chartreuseColor;
+ (instancetype)hollyGreenColor;
+ (instancetype)oliveColor;
+ (instancetype)oliveDrabColor;
+ (instancetype)moneyGreenColor;
+ (instancetype)honeydewColor;
+ (instancetype)limeColor;
+ (instancetype)cardTableColor;


///-----------------------------------------------------------------
/// Reds
///-----------------------------------------------------------------
+ (instancetype)salmonColor;
+ (instancetype)brickRedColor;
+ (instancetype)easterPinkColor;
+ (instancetype)grapefruitColor;
+ (instancetype)pinkColor;
+ (instancetype)indianRedColor;
+ (instancetype)strawberryColor;
+ (instancetype)coralColor;
+ (instancetype)maroonColor;
+ (instancetype)watermelonColor;
+ (instancetype)tomatoColor;
+ (instancetype)pinkLipstickColor;
+ (instancetype)paleRoseColor;
+ (instancetype)crimsonColor;


///-----------------------------------------------------------------
/// Purples
///-----------------------------------------------------------------
+ (instancetype)eggplantColor;
+ (instancetype)pastelPurpleColor;
+ (instancetype)palePurpleColor;
+ (instancetype)coolPurpleColor;
+ (instancetype)violetColor;
+ (instancetype)plumColor;
+ (instancetype)lavenderColor;
+ (instancetype)raspberryColor;
+ (instancetype)fuschiaColor;
+ (instancetype)grapeColor;
+ (instancetype)periwinkleColor;
+ (instancetype)orchidColor;


///-----------------------------------------------------------------
/// Yellows
///-----------------------------------------------------------------
+ (instancetype)goldenrodColor;
+ (instancetype)yellowGreenColor;
+ (instancetype)bananaColor;
+ (instancetype)mustardColor;
+ (instancetype)buttermilkColor;
+ (instancetype)goldColor;
+ (instancetype)creamColor;
+ (instancetype)lightCreamColor;
+ (instancetype)wheatColor;
+ (instancetype)beigeColor;


///-----------------------------------------------------------------
/// Oranges
///-----------------------------------------------------------------
+ (instancetype)peachColor;
+ (instancetype)burntOrangeColor;
+ (instancetype)pastelOrangeColor;
+ (instancetype)cantaloupeColor;
+ (instancetype)carrotColor;
+ (instancetype)mandarinColor;


///-----------------------------------------------------------------
/// Browns
///-----------------------------------------------------------------
+ (instancetype)chiliPowderColor;
+ (instancetype)burntSiennaColor;
+ (instancetype)chocolateColor;
+ (instancetype)coffeeColor;
+ (instancetype)cinnamonColor;
+ (instancetype)almonColor;
+ (instancetype)eggshellColor;
+ (instancetype)sandColor;
+ (instancetype)mudColor;
+ (instancetype)siennaColor;
+ (instancetype)dustColor;

@end
