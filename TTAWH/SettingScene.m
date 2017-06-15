//
//  SettingScene.m
//  TTAWH
//
//  Created by Kevin li on 15/6/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import "SettingScene.h"

@implementation SettingScene{
    NSArray *_btnArray;
    SKSpriteNode *_returnNode;
}


- (void)didMoveToView:(SKView *)view {
    _returnNode = (SKSpriteNode*)[self childNodeWithName:@"//return"];
    _returnNode.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"ic_setting_back"]];
    NSArray* btnNames = @[@"btn1", @"btn2", @"btn3", @"btn4", @"btn5"];
    NSMutableArray *btnNodeArray = [NSMutableArray new];
    for (NSString* name in btnNames) {
        [btnNodeArray addObject:[self childNodeWithName: [NSString stringWithFormat:@"//%@", name]]];
    }
    _btnArray = [btnNodeArray copy];
    
    for (SKSpriteNode *btnNode in _btnArray) {
        btnNode.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"notSelected"]];
    }
    //select first one
    ((SKSpriteNode*)_btnArray[0]).texture = [SKTexture textureWithImage:[UIImage imageNamed:@"selected"]];
    
    

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    if ([_returnNode containsPoint:touchLocation]) {
        SKScene *scene = (SKScene *)[SKScene nodeWithFileNamed:@"First"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        SKView *skView = (SKView *)self.view;
        [skView presentScene:scene];
    }
}

@end
