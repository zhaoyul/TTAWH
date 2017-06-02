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
#define CONTACT_MASK 0x1 << 8



@implementation MainScene{
    
    SKSpriteNode *_boomNode;
    CGPoint boomOriginPosition;
    
    SKSpriteNode *_fish1;
    CGPoint fish1OriginPosition;



}

-(void)didMoveToView:(SKView *)view{
    
    self.physicsWorld.contactDelegate = self;

    _boomNode = (SKSpriteNode *)[self childNodeWithName:@"//boom"];
    boomOriginPosition = _boomNode.position;
    _boomNode.physicsBody.fieldBitMask = BOOM_SPEED_FIELD;
    _boomNode.physicsBody.contactTestBitMask = CONTACT_MASK;

    
    _fish1 = (SKSpriteNode *)[self childNodeWithName:@"//fish1"];
    fish1OriginPosition = _fish1.position;
    _fish1.physicsBody.fieldBitMask = FISH1_SPEED_FIELD;
    _fish1.physicsBody.contactTestBitMask = CONTACT_MASK;


    
    vector_float3 targetPos = {0, 2, 0};
    SKFieldNode *velocityNode = [SKFieldNode velocityFieldWithVector:targetPos];
    velocityNode.categoryBitMask = BOOM_SPEED_FIELD;
    [self addChild:velocityNode];
    
    vector_float3 birk1TargetPos = {1, 0, 0};
    SKFieldNode *bird1VelocicyNode = [SKFieldNode velocityFieldWithVector:birk1TargetPos];
    bird1VelocicyNode.categoryBitMask = FISH1_SPEED_FIELD;
    [self addChild:bird1VelocicyNode];
    
    
    SKAction *boomWaitAction = [SKAction waitForDuration:1.5];
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
    
    SKAction *fish1WaitAction = [SKAction waitForDuration:1.5];
    SKAction *fish1Action = [SKAction runBlock:^{
        SKSpriteNode *anotherFish1 = [_fish1 copy];
        anotherFish1.position = fish1OriginPosition;
        anotherFish1.physicsBody.fieldBitMask = FISH1_SPEED_FIELD;
        [self addChild:anotherFish1];

    }];
    SKAction *fish1SeqAction = [SKAction sequence:@[fish1WaitAction, fish1Action]];
    SKAction *fish1RepeatAction = [SKAction repeatActionForever:fish1SeqAction];
    [self runAction:fish1RepeatAction];

    
    
    
    

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
    [cloud runAction:seqAction];
    
    

    
}
- (void)didEndContact:(SKPhysicsContact *)contact{
    
}


@end
