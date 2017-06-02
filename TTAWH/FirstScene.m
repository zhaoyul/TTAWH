//
//  FirstScene.m
//  TTAWH
//
//  Created by Zhaoyu Li on 1/5/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import "FirstScene.h"

@implementation FirstScene{
    SKNode *_boyNode;
    SKLabelNode *_label;
    SKAudioNode *_backgroundSoundNode;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    // Get label node from scene and store it for use later
    _boyNode = (SKNode *)[self childNodeWithName:@"//boy"];
    

    NSURL *musicURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"welcome" ofType:@"mp3"]];
    _backgroundSoundNode = [[SKAudioNode alloc] initWithURL:musicURL];
    [self addChild:_backgroundSoundNode];
    
    
    
}




//- (void)touchDownAtPoint:(CGPoint)pos {
//    SKShapeNode *n = [_spinnyNode copy];
//    n.position = pos;
//    n.strokeColor = [SKColor greenColor];
//    [self addChild:n];
//}
//
//- (void)touchMovedToPoint:(CGPoint)pos {
//    SKShapeNode *n = [_spinnyNode copy];
//    n.position = pos;
//    n.strokeColor = [SKColor blueColor];
//    [self addChild:n];
//}
//
//- (void)touchUpAtPoint:(CGPoint)pos {
//    SKShapeNode *n = [_spinnyNode copy];
//    n.position = pos;
//    n.strokeColor = [SKColor redColor];
//    [self addChild:n];
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    // Run 'Pulse' action from 'Actions.sks'
//    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];
//    
//    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
//}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
//}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    if ([_boyNode containsPoint:touchLocation]) {
        // Load the SKScene from 'GameScene.sks'
        
//        [self removeActionForKey:@"WelcomeBackgroundMusicAction"];

        GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"Main"];
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        SKView *skView = (SKView *)self.view;
        
        // Present the scene
        [skView presentScene:scene];

    }
}
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
//}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
