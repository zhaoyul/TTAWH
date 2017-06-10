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
    SKSpriteNode *_fish4_score;
    SKSpriteNode *_fish5_score;
    SKSpriteNode *_fish6_score;
    SKSpriteNode *_fish7_score;
    SKSpriteNode *_fish8_score;
    SKSpriteNode *_fish9_score;
    SKSpriteNode *_fish10_score;
    SKSpriteNode *_fish11_score;
    SKSpriteNode *_fish12_score;

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
    _fish4_score = (SKSpriteNode *)[self childNodeWithName:@"//fish4_score"];
    _fish5_score = (SKSpriteNode *)[self childNodeWithName:@"//fish5_score"];
    _fish6_score = (SKSpriteNode *)[self childNodeWithName:@"//fish6_score"];
    _fish7_score = (SKSpriteNode *)[self childNodeWithName:@"//fish7_score"];
    _fish8_score = (SKSpriteNode *)[self childNodeWithName:@"//fish8_score"];
    _fish9_score = (SKSpriteNode *)[self childNodeWithName:@"//fish9_score"];
    _fish10_score = (SKSpriteNode *)[self childNodeWithName:@"//fish10_score"];
    _fish11_score = (SKSpriteNode *)[self childNodeWithName:@"//fish11_score"];
    _fish12_score = (SKSpriteNode *)[self childNodeWithName:@"//fish12_score"];

    
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
    globalDict[@"score3"] = @(score3);
    _fish3_score.texture = textureArray[score3 % 10];
    
    NSInteger score4 = ((NSNumber*)globalDict[@"score4"]).integerValue;
    globalDict[@"score4"] = @(score4);
    _fish4_score.texture = textureArray[score1 % 10];
    
    NSInteger score5 = ((NSNumber*)globalDict[@"score5"]).integerValue;
    globalDict[@"score5"] = @(score5);
    _fish5_score.texture = textureArray[score5 % 10];
    
    NSInteger score6 = ((NSNumber*)globalDict[@"score6"]).integerValue;
    globalDict[@"score6"] = @(score6);
    _fish6_score.texture = textureArray[score3 % 10];
    
    NSInteger score7 = ((NSNumber*)globalDict[@"score7"]).integerValue;
    globalDict[@"score7"] = @(score7);
    _fish7_score.texture = textureArray[score1 % 10];
    
    NSInteger score8 = ((NSNumber*)globalDict[@"score8"]).integerValue;
    globalDict[@"score8"] = @(score8);
    _fish8_score.texture = textureArray[score2 % 10];
    
    NSInteger score9 = ((NSNumber*)globalDict[@"score9"]).integerValue;
    globalDict[@"score9"] = @(score9);
    _fish9_score.texture = textureArray[score9 % 10];
    
    NSInteger score10 = ((NSNumber*)globalDict[@"score10"]).integerValue;
    globalDict[@"score10"] = @(score10);
    _fish11_score.texture = textureArray[score10 % 10];
    
    NSInteger score11 = ((NSNumber*)globalDict[@"score11"]).integerValue;
    globalDict[@"score11"] = @(score11);
    _fish11_score.texture = textureArray[score11 % 10];
    
    NSInteger score12 = ((NSNumber*)globalDict[@"score12"]).integerValue;
    globalDict[@"score12"] = @(score12);
    _fish12_score.texture = textureArray[score12 % 10];

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
