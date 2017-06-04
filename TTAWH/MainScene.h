//
//  mainScene.h
//  TTAWH
//
//  Created by Zhaoyu Li on 14/5/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"

@interface MainScene : SKScene <SKPhysicsContactDelegate>
@property (nonatomic, strong) AppDelegate * _Nonnull appDelegate;
@property (nonatomic, weak) UIViewController* _Nullable parentVC;

@end
