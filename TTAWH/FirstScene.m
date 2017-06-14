//
//  FirstScene.m
//  TTAWH
//
//  Created by Zhaoyu Li on 1/5/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import "FirstScene.h"
#import "AppDelegate.h"
#import "UserGuideViewController.h"
#import "GameViewController.h"

@implementation FirstScene{
    SKNode *_boyNode;
    SKNode *_guide;
    SKLabelNode *_label;
    SKAudioNode *_backgroundSoundNode;
    AppDelegate *_appDelegate;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    // Get label node from scene and store it for use later
    _boyNode = (SKNode *)[self childNodeWithName:@"//boy"];
    _guide = (SKNode *)[self childNodeWithName:@"//guide"];
    _label = (SKLabelNode*) [self childNodeWithName:@"//statusLabel"];
    _appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    //sure there is memory leak, but I dont care
    _appDelegate.gameState = malloc(sizeof(GameState));
    
    _appDelegate.gameState->breathIn_interval = 0;
    _appDelegate.gameState->round = 0;
    _appDelegate.gameState->state = breathOutStop;
    _appDelegate.gameState->start_time = [NSDate timeIntervalSinceReferenceDate];

    _appDelegate.globalDic = [NSMutableDictionary dictionaryWithDictionary: @{@"score1": @0,
                                                                              @"score2": @0,
                                                                              @"score3": @0,
                                                                              @"score4": @0,
                                                                              @"score5": @0,
                                                                              @"score6": @0,
                                                                              @"score7": @0,
                                                                              @"score8": @0,
                                                                              @"score9": @0,
                                                                              @"score10": @0,
                                                                              @"score11": @0,
                                                                              @"score12": @0,}];


    

    NSURL *musicURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"welcome" ofType:@"mp3"]];
    _backgroundSoundNode = [[SKAudioNode alloc] initWithURL:musicURL];
    [self addChild:_backgroundSoundNode];
}




- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    if ([_boyNode containsPoint:touchLocation]) {
        if (_appDelegate.peripheral || YES) {
            GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"Main"];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            
            SKView *skView = (SKView *)self.view;
            
            [skView presentScene:scene];
        }
      
    }
    else if([_guide containsPoint:touchLocation]){
        GameViewController *parentVC = (GameViewController*) self.parentVC;
        [parentVC createUserGuide];
        
    }
}



-(void)update:(CFTimeInterval)currentTime {
    if (_appDelegate.peripheral) {
        _label.text = NSLocalizedString(@"deviceIsOn", nil);
    } else {
        _label.text = NSLocalizedString(@"turnOnDevice", nil);

    }
}

@end
