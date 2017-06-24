//
//  AppDelegate.h
//  TTAWH
//
//  Created by Zhaoyu Li on 30/4/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define kINNotificationIdentifier @"IN"
#define kOUTNotificationIdentifier @"OUT"
#define kSTOPNotificationIdentifier @"STOP"

#define kDISCONNECTNotificationIdentifier @"DISCONNECT"

#define ENOUGH_TIME 1.0

#define TOP5RANK @"TOPRANK"


typedef enum inOutState{
    breathIn, breathOut, breathInStop, breathOutStop
}inOutState;

typedef struct GameState {
    inOutState state;
    NSTimeInterval breathIn_interval ;
    NSTimeInterval start_time;
    NSInteger round;
    NSTimeInterval totalTime;
    NSInteger currentScore;//当前关卡得分
} GameState;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * _Nullable window;

@property (strong, nonatomic) NSMutableDictionary * _Nonnull globalDic;

@property (nonatomic, assign) GameState * _Nullable gameState;

@property (nonatomic, strong) CBPeripheral * _Nullable peripheral;

@property (nonatomic, strong) NSMutableArray * _Nullable topFive;

@property (nonatomic, assign) NSTimeInterval totalTimeInterval;
@property (nonatomic, assign) NSTimeInterval statTimeInterval;
@property (nonatomic, assign) NSTimeInterval endTimeInterval;






- (void) startScan;

-(void)changeWuhuaRate:(uint8_t) val;


@end

