//
//  mainScene.m
//  TTAWH
//
//  Created by Zhaoyu Li on 14/5/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import "MainScene.h"
#import "AppDelegate.h"
#import "SummaryScene.h"


#define BOOM_SPEED_FIELD  0x1 << 1      //2
#define FISH1_SPEED_FIELD 0x1 << 2      //4
#define FISH2_SPEED_FIELD 0x1 << 3      //8
#define FISH3_SPEED_FIELD 0x1 << 4      //16

#define CONTACT_MASK 0x1 << 8

#define radians(degrees)  (degrees)*M_PI/180.0f


#define BOMBSPEED 10
#define FISH1SPEED 2.0
#define FISH2SPEED 1.5
#define FISH3SPEED 1.0




@implementation MainScene{

    
    SKSpriteNode *_boomNode;
    CGPoint boomOriginPosition;
    
    SKSpriteNode *_fish1;
    CGPoint fish1OriginPosition;
    
    SKSpriteNode *_fish2;
    CGPoint fish2OriginPosition;
    
    SKSpriteNode *_fish3;
    CGPoint fish3OriginPosition;
    
    SKSpriteNode *_fish1_score;
    SKSpriteNode *_fish2_score;
    SKSpriteNode *_fish3_score;
    
    SKSpriteNode *_fish1_icon;
    SKSpriteNode *_fish2_icon;
    SKSpriteNode *_fish3_icon;
    
    SKSpriteNode *_timerBar;
    SKLabelNode *_timerLabel;
    
    SKSpriteNode *test;

    
    NSArray *textureArray;
    
    NSMutableDictionary *globalDict;
    
    NSInteger _times;
    


}



-(void)breathOutAction{


    
    if(self.appDelegate.gameState->breathIn_interval > ENOUGH_TIME*0.75) {
        _boomNode.physicsBody.dynamic = YES;
    } else {
        [self explodAtPosition:boomOriginPosition];
        SKAction *hide = [SKAction fadeOutWithDuration:0.01];
        SKAction *wait = [SKAction waitForDuration:0.2];
        SKAction *show = [SKAction fadeInWithDuration:0.01];
        SKAction *seq = [SKAction sequence:@[hide,wait, show]];
        [_boomNode runAction:seq];
        

    }


}

-(void)breathInAction{
    SKAction *moveToBoomOrigin = [SKAction moveTo:boomOriginPosition duration:0.01];
    [_boomNode runAction:moveToBoomOrigin];
    _boomNode.physicsBody.dynamic = NO;
    
}


-(UIImage*) getImageWithPercent:(CGFloat) percent andSize:(CGSize) size{
    UIColor *fillColor = [UIColor colorWithRed:250.0/255.0 green:215.0/255.0 blue:144.0/255.0 alpha:1.0];
    UIColor *boarderColor = [UIColor whiteColor];
    
    CGRect boarderRect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath* outerPath = [UIBezierPath bezierPathWithRoundedRect:boarderRect cornerRadius:5];

    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [boarderColor setStroke];
    [UIColor.redColor setFill];

//    CGContextClosePath(contextRef);
    CGContextAddPath(contextRef, outerPath.CGPath);
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
    CGFloat boarderWidth = 4;
    
    CGFloat barWidth = (size.width - 2*boarderWidth) * percent;
    CGRect barRect = CGRectMake(boarderWidth, boarderWidth, barWidth, size.height - 2*boarderWidth);
    UIBezierPath* innerPath = [UIBezierPath bezierPathWithRoundedRect:barRect cornerRadius:10];
    [fillColor setFill];

    CGContextAddPath(contextRef, innerPath.CGPath);
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *spiteImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return spiteImage;
}

static UIImage *circularImageWithImage(CGSize size, CGFloat percent)
{
    if (percent > 0.75) {
        percent = 1.0;
    }
    
    //支持retina高分截屏的关键
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    UIColor *fillColor = [self fromGreenToRed:percent*0.01];
    CGContextSetRGBFillColor(context, 1 - percent, percent, 0.0, 1.0);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 0.6);
    
    //扇形参数
    double radius=size.height/2.0;                   //半径
    int startX=size.width/2.0;                      //圆心x坐标
    int startY=size.height/2.0;                     //圆心y坐标
    double pieStart=0;                  //起始的角度
    double pieCapacity=360*percent;     //角度增量值
    int clockwise=0;                   //0＝顺时针,1＝逆时针
    
    //顺时针画扇形
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieStart+pieCapacity), clockwise);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    
    //生成图片  
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();  
    UIGraphicsEndImageContext();
    return resImage;

}


-(void)didMoveToView:(SKView *)view{
    
    /////////////////TEST//////////////////////
    test = (SKSpriteNode *)[self childNodeWithName:@"//test"];
    

    
    /////////////////INIT//////////////////////
    self.appDelegate =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    globalDict = self.appDelegate.globalDic;
    
    //////////////////NOTIFICATION/////////////
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(breathOutAction) name:kOUTNotificationIdentifier object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(breathInAction) name:kINNotificationIdentifier object:nil];
    
    //////////////////TIME BAR////////////////
    _timerBar =  [SKSpriteNode new];
    CGSize sceneSize =  self.size;
    CGFloat height = sceneSize.height;
    CGFloat width = sceneSize.width;
    CGSize barSize = CGSizeMake(width/4.0, height/20.0);
    _timerBar.size = barSize;
    _timerBar.position = CGPointMake(0 , height/2 - 20 - height/20);
    

    _times = 0;
    SKAction *barAction = [SKAction runBlock:^{
        _times = _times + 1;
        CGFloat percent = _times/60.0;
        
        UIImage *image = [self getImageWithPercent:percent andSize:barSize];
        
        _timerBar.texture = [SKTexture textureWithImage:image];
        _timerLabel.text = [NSString stringWithFormat:@"%ld", _times];
        if (_times == 60) {
            SummaryScene *scene = (SummaryScene *)[SKScene nodeWithFileNamed:@"Summary"];
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = SKSceneScaleModeAspectFill;
            
            SKView *skView = (SKView *)self.view;
            
            // Present the scene
            [skView presentScene:scene];
        }
    }];
    SKAction *waitAction = [SKAction waitForDuration:1.0];
    SKAction *seqAction = [SKAction sequence:@[barAction, waitAction]];
    SKAction *repeatAction = [SKAction repeatAction:seqAction count:60];

    [self runAction:repeatAction];


    //////////////////TEXTURE ARRAY////////////
    textureArray = @[[SKTexture textureWithImageNamed:@"grade0" ],
                     [SKTexture textureWithImageNamed:@"grade1" ],
                     [SKTexture textureWithImageNamed:@"grade2" ],
                     [SKTexture textureWithImageNamed:@"grade3" ],
                     [SKTexture textureWithImageNamed:@"grade4" ],
                     [SKTexture textureWithImageNamed:@"grade5" ],
                     [SKTexture textureWithImageNamed:@"grade6" ],
                     [SKTexture textureWithImageNamed:@"grade7" ],
                     [SKTexture textureWithImageNamed:@"grade8" ],
                     [SKTexture textureWithImageNamed:@"grade9" ],];
    /////////////back ground music/////////////
    NSURL *musicURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"main" ofType:@"mp3"]];
    SKNode *backgroundSoundNode = [[SKAudioNode alloc] initWithURL:musicURL];
    [self addChild:backgroundSoundNode];
    
    self.physicsWorld.contactDelegate = self;
    
    //////////////////////////////////////////////////////////////
    _boomNode = (SKSpriteNode *)[self childNodeWithName:@"//boom"];
    boomOriginPosition = _boomNode.position;
    _boomNode.physicsBody.fieldBitMask = BOOM_SPEED_FIELD;
    _boomNode.physicsBody.contactTestBitMask = CONTACT_MASK;
    _boomNode.physicsBody.dynamic = NO;

    
    _fish1 = (SKSpriteNode *)[self childNodeWithName:@"//fish1"];
    fish1OriginPosition = _fish1.position;
    _fish1.physicsBody.fieldBitMask = FISH1_SPEED_FIELD;
    _fish1.physicsBody.contactTestBitMask = CONTACT_MASK;
    
    _fish2 = (SKSpriteNode *)[self childNodeWithName:@"//fish2"];
    fish2OriginPosition = _fish2.position;
    _fish2.physicsBody.fieldBitMask = FISH2_SPEED_FIELD;
    _fish2.physicsBody.contactTestBitMask = CONTACT_MASK;
    
    _fish3 = (SKSpriteNode *)[self childNodeWithName:@"//fish3"];
    fish3OriginPosition = _fish3.position;
    _fish3.physicsBody.fieldBitMask = FISH3_SPEED_FIELD;
    _fish3.physicsBody.contactTestBitMask = CONTACT_MASK;
    
    //score
    _fish1_score = (SKSpriteNode *)[self childNodeWithName:@"//fish1_score"];
    _fish2_score = (SKSpriteNode *)[self childNodeWithName:@"//fish2_score"];
    _fish3_score = (SKSpriteNode *)[self childNodeWithName:@"//fish3_score"];
    
    //icon
    _fish1_icon = (SKSpriteNode *)[self childNodeWithName:@"//fish1_icon"];
    _fish2_icon = (SKSpriteNode *)[self childNodeWithName:@"//fish2_icon"];
    _fish3_icon = (SKSpriteNode *)[self childNodeWithName:@"//fish3_icon"];
    //timer
    _timerBar = (SKSpriteNode*)[self childNodeWithName:@"//timerBar"];
    _timerLabel = (SKLabelNode*)[self childNodeWithName:@"//timerLabel"];
    

    ////////////////////////BOMB////////////////////////////////
    
    vector_float3 targetPos = {0, BOMBSPEED, 0};
    SKFieldNode *velocityNode = [SKFieldNode velocityFieldWithVector:targetPos];
    velocityNode.categoryBitMask = BOOM_SPEED_FIELD;
    [self addChild:velocityNode];
    

    ////////////////////////FISH1////////////////////////////////

    
    vector_float3 fish1TargetPos = {FISH1SPEED, 0, 0};
    SKFieldNode *fish1VelocicyNode = [SKFieldNode velocityFieldWithVector:fish1TargetPos];
    fish1VelocicyNode.categoryBitMask = FISH1_SPEED_FIELD;
    [self addChild:fish1VelocicyNode];
    
    
    
    SKAction *fish1WaitAction = [SKAction waitForDuration:3];
    SKAction *fish1Action = [SKAction runBlock:^{
        SKSpriteNode *anotherFish1 = [_fish1 copy];
        anotherFish1.name = @"fish1";
        anotherFish1.position = fish1OriginPosition;
        [self addChild:anotherFish1];

    }];
    SKAction *fish1SeqAction = [SKAction sequence:@[fish1WaitAction, fish1Action]];
    SKAction *fish1RepeatAction = [SKAction repeatActionForever:fish1SeqAction];
    [self runAction:fish1RepeatAction];
    
    ////////////////////////FISH2////////////////////////////////
    
    
    vector_float3 fish2TargetPos = {FISH2SPEED, 0, 0};
    SKFieldNode *fish2VelocicyNode = [SKFieldNode velocityFieldWithVector:fish2TargetPos];
    fish2VelocicyNode.categoryBitMask = FISH2_SPEED_FIELD;
    [self addChild:fish2VelocicyNode];
    
    
    
    SKAction *fish2WaitAction = [SKAction waitForDuration:3];
    SKAction *fish2Action = [SKAction runBlock:^{
        SKSpriteNode *anotherFish2 = [_fish2 copy];
        anotherFish2.name = @"fish2";

        anotherFish2.position = fish2OriginPosition;
        [self addChild:anotherFish2];
        
    }];
    SKAction *fish2SeqAction = [SKAction sequence:@[fish2WaitAction, fish2Action]];
    SKAction *fish2RepeatAction = [SKAction repeatActionForever:fish2SeqAction];
    [self runAction:fish2RepeatAction];
    
    
    ////////////////////////FISH3////////////////////////////////
    
    
    vector_float3 fish3TargetPos = {FISH3SPEED, 0, 0};
    SKFieldNode *fish3VelocicyNode = [SKFieldNode velocityFieldWithVector:fish3TargetPos];
    fish3VelocicyNode.categoryBitMask = FISH3_SPEED_FIELD;
    [self addChild:fish3VelocicyNode];
    
    
    
    SKAction *fish3WaitAction = [SKAction waitForDuration:3];
    SKAction *fish3Action = [SKAction runBlock:^{
        SKSpriteNode *anotherFish3 = [_fish3 copy];
        anotherFish3.name = @"fish3";

        anotherFish3.position = fish3OriginPosition;
        [self addChild:anotherFish3];
        
    }];
    SKAction *fish3SeqAction = [SKAction sequence:@[fish3WaitAction, fish3Action]];
    SKAction *fish3RepeatAction = [SKAction repeatActionForever:fish3SeqAction];
    [self runAction:fish3RepeatAction];

}

-(void)update:(NSTimeInterval)currentTime{
    if (_boomNode.position.y > 1000) {
        _boomNode.position = boomOriginPosition;
        _boomNode.physicsBody.dynamic = NO;
    }
    CGFloat percent = self.appDelegate.gameState->breathIn_interval/ENOUGH_TIME;
    UIImage *testImg = circularImageWithImage(test.size, percent);
    test.texture = [SKTexture textureWithImage: testImg];
 }


- (SKAction *)iconAction {
    SKAction *leftMoveAction = [SKAction moveByX:-5 y:0 duration:0.05];
    SKAction *rightMoveAction = [SKAction moveByX:10 y:0 duration:0.1];
    SKAction *moveSeq = [SKAction sequence:@[leftMoveAction, rightMoveAction, leftMoveAction]];
        
    SKAction *zoomInAction = [SKAction scaleBy:0.8 duration:0.1];
    SKAction *zoomOutAction = [SKAction scaleBy:1.25 duration:0.1];
    SKAction *zoomSeq = [SKAction sequence:@[zoomInAction, zoomOutAction]];
        
    SKAction *group = [SKAction group:@[moveSeq, zoomSeq]];
    return group;
}

- (void)didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody *a = contact.bodyA;
    SKPhysicsBody *b = contact.bodyB;
    
    SKSpriteNode *bomb;
    SKSpriteNode *fish;
    
    if ([a.node.name isEqualToString:@"boom"]) {
        bomb = (SKSpriteNode*)a.node;
        fish = (SKSpriteNode*)b.node;
    } else {
        bomb = (SKSpriteNode*)b.node;
        fish = (SKSpriteNode*)a.node;
    }
   
    
    if ([a.node.name isEqualToString:@"fish1"]  || [b.node.name isEqualToString:@"fish1"]) {
        NSInteger score1 = ((NSNumber*)globalDict[@"score1"]).integerValue + 1 ;
        globalDict[@"score1"] = @(score1);
        SKAction *group;
        group = [self iconAction];
        
        [_fish1_icon runAction:group];
        
        _fish1_score.texture = textureArray[score1 % 10];
    } else if([a.node.name isEqualToString:@"fish2"]  || [b.node.name isEqualToString:@"fish2"]){
        NSInteger score2 = ((NSNumber*)globalDict[@"score2"]).integerValue + 1 ;
        globalDict[@"score2"] = @(score2);
        _fish2_score.texture = textureArray[score2 % 10];
        
        SKAction *group;
        group = [self iconAction];
        [_fish2_icon runAction:group];

    } else if([a.node.name isEqualToString:@"fish3"]  || [b.node.name isEqualToString:@"fish3"]){
        NSInteger score3 = ((NSNumber*)globalDict[@"score3"]).integerValue + 1 ;
        globalDict[@"score3"] = @(score3);
        _fish3_score.texture = textureArray[score3 % 10];
        
        SKAction *group;
        group = [self iconAction];
        [_fish3_icon runAction:group];
    }
    
    [fish removeFromParent];
    
    CGPoint explodPosition = contact.contactPoint;
    
    [self explodAtPosition:explodPosition];
    
    SKAction *moveToBoomOrigin = [SKAction moveTo:boomOriginPosition duration:0.01];
    [_boomNode runAction:moveToBoomOrigin];
    _boomNode.physicsBody.dynamic = NO;
    
}

-(void) explodAtPosition:(CGPoint) position{
    SKTexture *cloudTexture = [SKTexture textureWithImageNamed:@"cloud"];
    SKSpriteNode *cloud = [SKSpriteNode spriteNodeWithTexture:cloudTexture size:CGSizeMake(50, 50)];
    cloud.position = position;
    [self addChild:cloud];
    SKAction *cloudScale = [SKAction scaleBy:2.0 duration:0.1];
    SKAction *cloudFaceout = [SKAction fadeOutWithDuration:0.1];
    SKAction *seqAction = [SKAction sequence:@[cloudScale, cloudFaceout]];
    SKAction *bombSound = [SKAction playSoundFileNamed:@"bomb.wav" waitForCompletion:NO];
    SKAction *group = [SKAction group:@[seqAction, bombSound]];
    [cloud runAction:group];
}
                              

/////////////////////////////touch hander/////////////////////////
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKAction *moveToBoomOrigin = [SKAction moveTo:boomOriginPosition duration:0.01];
    [_boomNode runAction:moveToBoomOrigin];
    _boomNode.physicsBody.dynamic = NO;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
        _boomNode.physicsBody.dynamic = YES;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    _boomNode.position = boomOriginPosition;

}




@end
