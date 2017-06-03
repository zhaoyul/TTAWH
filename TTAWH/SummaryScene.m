//
//  SummaryScene.m
//  TTAWH
//
//  Created by Kevin li on 4/6/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import "AppDelegate.h"
#import "SummaryScene.h"
#import "FirstScene.h"

@implementation SummaryScene{
    SKSpriteNode *_fish1_score;
    SKSpriteNode *_fish2_score;
    SKSpriteNode *_fish3_score;
    NSMutableDictionary *globalDict;
    AppDelegate *appDelegate;

}


-(void)didMoveToView:(SKView *)view{
    appDelegate =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    globalDict = appDelegate.globalDic;
    //score
    _fish1_score = (SKSpriteNode *)[self childNodeWithName:@"//fish1_score"];
    _fish2_score = (SKSpriteNode *)[self childNodeWithName:@"//fish2_score"];
    _fish3_score = (SKSpriteNode *)[self childNodeWithName:@"//fish3_score"];
    
    NSArray *textureArray = @[[SKTexture textureWithImageNamed:@"grade0" ],
                              [SKTexture textureWithImageNamed:@"grade1" ],
                              [SKTexture textureWithImageNamed:@"grade2" ],
                              [SKTexture textureWithImageNamed:@"grade3" ],
                              [SKTexture textureWithImageNamed:@"grade4" ],
                              [SKTexture textureWithImageNamed:@"grade5" ],
                              [SKTexture textureWithImageNamed:@"grade6" ],
                              [SKTexture textureWithImageNamed:@"grade7" ],
                              [SKTexture textureWithImageNamed:@"grade8" ],
                              [SKTexture textureWithImageNamed:@"grade9" ],];
    
    NSInteger score1 = ((NSNumber*)globalDict[@"score1"]).integerValue;
    globalDict[@"score1"] = @(score1);
    _fish1_score.texture = textureArray[score1 % 10];
    
    NSInteger score2 = ((NSNumber*)globalDict[@"score2"]).integerValue;
    globalDict[@"score2"] = @(score2);
    _fish2_score.texture = textureArray[score2 % 10];
    
    NSInteger score3 = ((NSNumber*)globalDict[@"score3"]).integerValue;
    globalDict[@"score3"] = @(score1);
    _fish3_score.texture = textureArray[score3 % 10];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     FirstScene *scene = (FirstScene *)[SKScene nodeWithFileNamed:@"First"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];

}

@end
