//
//  CircularProgressNode.m
//  TTAWH
//
//  Created by Zhaoyu Li on 13/5/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import "CircularProgressNode.h"

@implementation CircularProgressNode{
    CGFloat _radius;
    CGFloat _startAngle;
}

-(instancetype)initWithRadius:(CGFloat)radius andColor:(UIColor *)color andWidth:(CGFloat)width andStartAngle:(CGFloat)startAngle{
    if ( self = [super init] ) {
        _startAngle = radius;
        self.strokeColor = color;
        self.lineWidth = width;
        _startAngle = startAngle;
        
        [self updateProgress:0.0];
    }
    return self;
}

- (void)updateProgress:(CGFloat)percentage{
    CGFloat progress = percentage <= 0.0 ? 1.0 : (percentage >= 1.0 ? 0.0 : 1.0 - percentage);
    CGFloat endAngle = _startAngle + progress * 2.0 * M_PI;
    self.path = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:_radius startAngle:_startAngle endAngle:endAngle clockwise:true].CGPath;
}

@end
