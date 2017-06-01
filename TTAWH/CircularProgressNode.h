//
//  CircularProgressNode.h
//  TTAWH
//
//  Created by Zhaoyu Li on 13/5/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CircularProgressNode : SKShapeNode
- (instancetype)initWithRadius: (CGFloat) radius
                      andColor:(SKColor*) color
                      andWidth: (CGFloat) width
                 andStartAngle: (CGFloat) startAngle;
-(void) updateProgress:(CGFloat) percentage;
@end
