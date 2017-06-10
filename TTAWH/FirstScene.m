//
//  FirstScene.m
//  TTAWH
//
//  Created by Zhaoyu Li on 1/5/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import "FirstScene.h"
//#import "AppDelegate.h"
#import "UserGuideViewController.h"
#import "GameViewController.h"

@implementation FirstScene{
    SKNode *_boyNode;
    SKNode *_guide;
    SKLabelNode *_label;
    SKAudioNode *_backgroundSoundNode;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    // Get label node from scene and store it for use later
    _boyNode = (SKNode *)[self childNodeWithName:@"//boy"];
    _guide = (SKNode *)[self childNodeWithName:@"//guide"];

    

    NSURL *musicURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"welcome" ofType:@"mp3"]];
    _backgroundSoundNode = [[SKAudioNode alloc] initWithURL:musicURL];
    [self addChild:_backgroundSoundNode];
}




- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    if ([_boyNode containsPoint:touchLocation]) {
        GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"Main"];
                scene.scaleMode = SKSceneScaleModeAspectFill;
        
        SKView *skView = (SKView *)self.view;
        
        [skView presentScene:scene];

    }
    else if([_guide containsPoint:touchLocation]){
        GameViewController *parentVC = (GameViewController*) self.parentVC;
        [parentVC createUserGuide];
        
    }
}



-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
