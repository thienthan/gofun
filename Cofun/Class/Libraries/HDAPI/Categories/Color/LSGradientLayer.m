//
//  LSGradientLayer.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "LSGradientLayer.h"
#import "UIColor+Extensions.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation LSGradientLayer

// How to use
/*
 //CAGradientLayer *bgLayer = [LSGradientLayer blueGradient];
 //bgLayer.frame = self.view.bounds;
 //[self.view.layer insertSublayer:bgLayer atIndex:0];
 //[self.view.layer addSublayer:gradientLayer];
 */

+ (CAGradientLayer *)redGradient {
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor iOS7redGradientStartColor] CGColor], (id)[[UIColor iOS7redGradientEndColor] CGColor], nil];
    
    return gradientLayer;
}

+ (CAGradientLayer *)oranggeGradient {
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor iOS7orangeGradientStartColor] CGColor], (id)[[UIColor iOS7orangeGradientEndColor] CGColor], nil];
    
    return gradientLayer;
}

+ (CAGradientLayer *)yellowGradient {
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor iOS7yellowGradientStartColor] CGColor], (id)[[UIColor iOS7yellowGradientEndColor] CGColor], nil];
    
    return gradientLayer;
}

+ (CAGradientLayer *)greenGradient {
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor iOS7greenGradientStartColor] CGColor], (id)[[UIColor iOS7greenGradientEndColor] CGColor], nil];
    
    return gradientLayer;
}

+ (CAGradientLayer *)tealGradient {
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor iOS7tealGradientStartColor] CGColor], (id)[[UIColor iOS7tealGradientEndColor] CGColor], nil];
    
    return gradientLayer;
}

+ (CAGradientLayer *)blueGradient {
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor iOS7blueGradientStartColor] CGColor], (id)[[UIColor iOS7blueGradientEndColor] CGColor], nil];
    
    return gradientLayer;
}

+ (CAGradientLayer *)violetGradient {
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor iOS7violetGradientStartColor] CGColor], (id)[[UIColor iOS7violetGradientEndColor] CGColor], nil];
    
    return gradientLayer;
}

+ (CAGradientLayer *)magentaGradient {
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor iOS7magentaGradientStartColor] CGColor], (id)[[UIColor iOS7magentaGradientEndColor] CGColor], nil];
    
    return gradientLayer;
}

+ (CAGradientLayer *)blackGradient {
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor iOS7blackGradientStartColor] CGColor], (id)[[UIColor iOS7blackGradientEndColor] CGColor], nil];
    
    return gradientLayer;
}

+ (CAGradientLayer *)silverGradient {
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor iOS7silverGradientStartColor] CGColor], (id)[[UIColor iOS7silverGradientEndColor] CGColor], nil];
    
    return gradientLayer;
}

@end
