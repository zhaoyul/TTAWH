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
} GameState;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableDictionary *globalDic;

@property (nonatomic, assign) GameState *gameState;

@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) NSMutableArray *topFive;




- (void) startScan;



@end

