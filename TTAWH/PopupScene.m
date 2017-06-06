//
//  PopupScene.m
//  TTAWH
//
//  Created by Kevin li on 6/6/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import "PopupScene.h"
#import "AppDelegate.h"
#import "MainScene.h"

@implementation PopupScene{
    SKLabelNode *_score;
    SKSpriteNode *_restart;
    SKSpriteNode *_next;
    SKSpriteNode *_bgNode;
    NSMutableDictionary *globalDict;
    AppDelegate *appDelegate;
}

-(void)setBgimg:(UIImage *)bgimg{
    _bgimg = bgimg;
}

-(void)didMoveToView:(SKView *)view{
    appDelegate =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    globalDict = appDelegate.globalDic;
    //score
    _score = (SKLabelNode *)[self childNodeWithName:@"//score"];
    _restart = (SKSpriteNode *)[self childNodeWithName:@"//restart"];
    _next = (SKSpriteNode *)[self childNodeWithName:@"//next"];
    _bgNode = (SKSpriteNode*)[self childNodeWithName:@"//bgNode"];
    _bgNode.texture = [SKTexture textureWithImage:_bgimg];

    NSInteger score1 = ((NSNumber*)appDelegate.globalDic[@"score1"]).integerValue;
    NSInteger score2 = ((NSNumber*)appDelegate.globalDic[@"score2"]).integerValue;
    NSInteger score3 = ((NSNumber*)appDelegate.globalDic[@"score3"]).integerValue;
    
    NSInteger score = score1*10 + score2*5 + score3;
    
    _score.text = [NSString stringWithFormat: @"%ld", (long)score];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    if ([_restart containsPoint:touchLocation]) {
        MainScene *scene = (MainScene *)[SKScene nodeWithFileNamed:@"Main"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        SKView *skView = (SKView *)self.view;
        
        [skView presentScene:scene];
        
    }
    
    if ([_next containsPoint:touchLocation]) {
        MainScene *scene = (MainScene *)[SKScene nodeWithFileNamed:@"Main"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        SKView *skView = (SKView *)self.view;
        
        [skView presentScene:scene];
        
    }


    
}
@end
