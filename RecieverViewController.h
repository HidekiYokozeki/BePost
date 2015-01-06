//
//  RecieverViewController.h
//  AddTest
//
//  Created by 横関秀樹 on 2014/04/30.
//  Copyright (c) 2014年 Hideki yokozeki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@import CoreLocation;
@import AudioToolbox;

@interface RecieverViewController : UIViewController<CLLocationManagerDelegate,ABUnknownPersonViewControllerDelegate>

@property (strong, nonatomic) NSUUID *proximityUUID;
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLBeaconRegion *region;

@property (nonatomic) NSNumber *currentMinor;
@property (nonatomic) NSNumber *currentMajor;


//@property (weak, nonatomic) IBOutlet UILabel *beaconLabel;

@property (weak, nonatomic) IBOutlet UITextField *IDField;

@property(copy, nonatomic) NSString *Name;
- (IBAction)AddressBtntap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *FacebookAddBtn;
- (IBAction)FacebookBtnTap:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *Load;
- (IBAction)PasteBtnTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *PasteBtn;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;


@end
