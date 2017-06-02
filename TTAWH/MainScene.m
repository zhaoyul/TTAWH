//
//  mainScene.m
//  TTAWH
//
//  Created by Zhaoyu Li on 14/5/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import "MainScene.h"

#define BOOM_SPEED_FIELD 0x1 << 0
#define FISH1_SPEED_FIELD 0x1 << 1
#define FISH2_SPEED_FIELD 0x1 << 2
#define FISH3_SPEED_FIELD 0x1 << 3

#define CONTACT_MASK 0x1 << 8


#define BOMBSPEED 4
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
    



}

-(void)didMoveToView:(SKView *)view{
    /////////////back ground music/////////////
    NSURL *musicURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"main" ofType:@"mp3"]];
    SKNode *backgroundSoundNode = [[SKAudioNode alloc] initWithURL:musicURL];
    [self addChild:backgroundSoundNode];

    
    self.physicsWorld.contactDelegate = self;

    _boomNode = (SKSpriteNode *)[self childNodeWithName:@"//boom"];
    boomOriginPosition = _boomNode.position;
    _boomNode.physicsBody.fieldBitMask = BOOM_SPEED_FIELD;
    _boomNode.physicsBody.contactTestBitMask = CONTACT_MASK;

    
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


    ////////////////////////BOMB////////////////////////////////
    
    vector_float3 targetPos = {0, BOMBSPEED, 0};
    SKFieldNode *velocityNode = [SKFieldNode velocityFieldWithVector:targetPos];
    velocityNode.categoryBitMask = BOOM_SPEED_FIELD;
    [self addChild:velocityNode];
    
    SKAction *boomWaitAction = [SKAction waitForDuration:3];
    SKAction *boomAction = [SKAction runBlock:^{
        SKSpriteNode *anotherBoom = [_boomNode copy];
        anotherBoom.position = boomOriginPosition;
        anotherBoom.physicsBody.fieldBitMask = BOOM_SPEED_FIELD;
        [self addChild:anotherBoom];
        [_boomNode removeFromParent];
        _boomNode = anotherBoom;
    }];
    SKAction *boomSeqAction = [SKAction sequence:@[boomWaitAction, boomAction]];
    SKAction *boomRepeatAction = [SKAction repeatActionForever:boomSeqAction];
    [self runAction:boomRepeatAction];

    ////////////////////////FISH1////////////////////////////////

    
    vector_float3 fish1TargetPos = {FISH1SPEED, 0, 0};
    SKFieldNode *fish1VelocicyNode = [SKFieldNode velocityFieldWithVector:fish1TargetPos];
    fish1VelocicyNode.categoryBitMask = FISH1_SPEED_FIELD;
    [self addChild:fish1VelocicyNode];
    
    
    
    SKAction *fish1WaitAction = [SKAction waitForDuration:3];
    SKAction *fish1Action = [SKAction runBlock:^{
        SKSpriteNode *anotherFish1 = [_fish1 copy];
        anotherFish1.position = fish1OriginPosition;
        anotherFish1.physicsBody.fieldBitMask = FISH1_SPEED_FIELD;
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
        anotherFish2.position = fish2OriginPosition;
        anotherFish2.physicsBody.fieldBitMask = FISH2_SPEED_FIELD;
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
        anotherFish3.position = fish3OriginPosition;
        anotherFish3.physicsBody.fieldBitMask = FISH3_SPEED_FIELD;
        [self addChild:anotherFish3];
        
    }];
    SKAction *fish3SeqAction = [SKAction sequence:@[fish3WaitAction, fish3Action]];
    SKAction *fish3RepeatAction = [SKAction repeatActionForever:fish3SeqAction];
    [self runAction:fish3RepeatAction];

    
    
    
    

}

-(void)update:(NSTimeInterval)currentTime{
 }


- (void)didBeginContact:(SKPhysicsContact *)contact{
    NSLog(@"-----------------------------");
    SKPhysicsBody *a = contact.bodyA;
    SKPhysicsBody *b = contact.bodyB;
    [a.node removeFromParent];
    [b.node removeFromParent];
    SKTexture *cloudTexture = [SKTexture textureWithImageNamed:@"cloud"];
    SKSpriteNode *cloud = [SKSpriteNode spriteNodeWithTexture:cloudTexture size:CGSizeMake(50, 50)];
    cloud.position = contact.contactPoint;
    [self addChild:cloud];
    SKAction *cloudScale = [SKAction scaleBy:2.0 duration:0.1];
    SKAction *cloudFaceout = [SKAction fadeOutWithDuration:0.1];
    SKAction *seqAction = [SKAction sequence:@[cloudScale, cloudFaceout]];
    SKAction *bombSound = [SKAction playSoundFileNamed:@"bomb.wav" waitForCompletion:NO];
    SKAction *group = [SKAction group:@[seqAction, bombSound]];
    [cloud runAction:group];

    

    
}
- (void)didEndContact:(SKPhysicsContact *)contact{
    
}


@end
