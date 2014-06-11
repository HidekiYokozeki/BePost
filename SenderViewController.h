//
//  SenderViewController.h
//  AddTest
//
//  Created by 横関秀樹 on 2014/04/30.
//  Copyright (c) 2014年 Hideki yokozeki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface SenderViewController : UIViewController<CBPeripheralManagerDelegate>

@property(nonatomic) CLBeaconRegion *region;
@property(nonatomic) CBPeripheralManager *manager;
@property(nonatomic) NSUUID *proximityUUID;
@property(copy, nonatomic) NSString *Name;
@property(copy, nonatomic) NSString *sendDataName;

@end
