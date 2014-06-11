//
//  RecieverViewController.m
//  AddTest
//
//  Created by 横関秀樹 on 2014/04/30.
//  Copyright (c) 2014年 Hideki yokozeki. All rights reserved.
//

#import "RecieverViewController.h"

@interface RecieverViewController (){
    
    BOOL Get_Start_Flag;
    BOOL Count_Start_Flag;
    NSInteger count;
    NSString *string;
    int C_change;
    int C_temp;
    int mode_estimate;
    UIActivityIndicatorView *indicator;
    NSTimer *timer;
    
}

@end

@implementation RecieverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[UINavigationBar appearance].barTintColor = [UIColor colorWithRed:0.000 green:0.549 blue:0.890 alpha:1.000];
    
         self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Back.png"]];

    
    self.currentMajor = @1;
    self.currentMinor = @1;
    Get_Start_Flag = YES;
    Count_Start_Flag = NO;
    count = 0;
    string = @"";
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor redColor];
    indicator.frame = CGRectMake(110, 250, 100, 100);
    
    // サブビューに追加する
    [self.view addSubview:indicator];

    if ([CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        // CLLocationManagerの生成とデリゲートの設定
        self.manager = [CLLocationManager new];
        self.manager.delegate = self;
        
        // 生成したUUIDからNSUUIDを作成
        NSString *uuid = @"1E21BCE0-7655-4647-B492-A3F8DE2F9A02";//@"1E21BCE0-7655-4647-B492-A3F8DE2F9A02";
        self.proximityUUID = [[NSUUID alloc] initWithUUIDString:uuid];
        
        // CLBeaconRegionを作成
        self.region = [[CLBeaconRegion alloc]
                       initWithProximityUUID:self.proximityUUID
                       identifier:@"jp.classmethod.testregion"];
        self.region.notifyOnEntry = YES;
        self.region.notifyOnExit = YES;
        self.region.notifyEntryStateOnDisplay = NO;
        
        // 領域監視を開始
        [self.manager startMonitoringForRegion:self.region];
        // 距離測定を開始
        [self.manager startRangingBeaconsInRegion:self.region];
        
    }
    
    UIImage* images = [UIImage imageNamed:@"bike.png"];
    self.Load.image = images;
    
}

// Beaconに入ったときに呼ばれる
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    
    //NSLog(@"AHHHHHH%@", NSStringFromSelector(_cmd));
    [self sendNotification:@"didEnterRegion"];
    //self.myLabel.text = @"in!";
}

// Beaconから出たときに呼ばれる
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    [self sendNotification:@"didExitRegion"];
}


// Beaconとの状態が確定したときに呼ばれる
- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    switch (state) {
        case CLRegionStateInside:
            NSLog(@"CLRegionStateInside");
            //[self playSound:@"enter"];
            break;
        case CLRegionStateOutside:
            NSLog(@"CLRegionStateOutside");
            //[self playSound:@"exit"];
            break;
        case CLRegionStateUnknown:
            NSLog(@"CLRegionStateUnknown");
            break;
        default:
            break;
    }
}

/*
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
}
*/

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
}


- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    CLLocationAccuracy locationAccuracy = 0.0;
    NSInteger rssi = 0;
    NSNumber* major = @0;
    NSNumber* minor = @0;
    
    // 最初のオブジェクト = 最も近いBeacon
    CLBeacon *beacon = beacons.firstObject;
    
    locationAccuracy = beacon.accuracy;
    rssi = beacon.rssi;
    major = beacon.major;
    minor = beacon.minor;
   
    /*
    self.uuidLabel.text = beacon.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", minor];
    self.accuracyLabel.text = [NSString stringWithFormat:@"%f", locationAccuracy];
    */
    
    
    if( ([major intValue] == 1 || [major intValue] == 2 || [major intValue] == 3) && Get_Start_Flag == YES){
        
        Count_Start_Flag = YES;
        Get_Start_Flag = NO;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        
        mode_estimate = [major intValue];
        [UIView commitAnimations];
        
        // クルクルと回し始める
        [indicator startAnimating];
        //self.titleLabel.text = @"受信中...";
        self.titleLabel.text = NSLocalizedString(@"Recieving...", nil);
        
    }
    
    if ([major intValue] == 0 && Count_Start_Flag == YES){
        
        Count_Start_Flag = NO;
        self.IDField.text = string;
        self.titleLabel.text = NSLocalizedString(@"Complete", nil);
        [indicator stopAnimating];
        
        if(mode_estimate == 1){
            
        }
        
        if(mode_estimate == 2){
            
            self.FacebookAddBtn.alpha = 1.0;
            self.titleLabel.alpha = 0;

            /*
            NSString *urlString = @"http://www.google.co.jp";
            NSURL *url = [NSURL URLWithString:urlString];
            
            // ブラウザを起動する
            [[UIApplication sharedApplication] openURL:url];
            */
            
            
            
        }
        
        if(mode_estimate == 3){
            
            self.AddressBtn.alpha = 1.0;
        
        }
        
        
    }
    
    if((Count_Start_Flag==YES) && [self.currentMajor intValue] != [major intValue]){
        
        C_change = [major intValue];
        C_temp = C_change >> 8;
        
        string = [NSString stringWithFormat:@"%@%c",string,C_temp];
        C_change = C_change - (C_temp << 8);
        
        if(C_change != 0){
        
            string = [NSString stringWithFormat:@"%@%c",string,C_change];
    
        }
        
    }
    
    if((Count_Start_Flag==YES) && [self.currentMinor intValue] != [minor intValue]){
        
        C_change = [minor intValue];
        C_temp = C_change >> 8;
        
        if(C_change != 0){
        
        string = [NSString stringWithFormat:@"%@%c",string,C_temp];
        C_change = C_change - (C_temp << 8);
        
        if(C_change != 0){
            
            string = [NSString stringWithFormat:@"%@%c",string, C_change];
            
            }
        }
        
    }
    
    self.currentMajor = major;
    self.currentMinor = minor;
    //self.TestLable.text = string;
  
    
    /*
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    CLProximity proximity = CLProximityUnknown;
    NSString *proximityString = @"CLProximityUnknown";
    CLLocationAccuracy locationAccuracy = 0.0;
    NSInteger rssi = 0;
    NSNumber* major = @0;
    NSNumber* minor = @0;
    
    // 最初のオブジェクト = 最も近いBeacon
    CLBeacon *beacon = beacons.firstObject;
    
    proximity = beacon.proximity;
    locationAccuracy = beacon.accuracy;
    rssi = beacon.rssi;
    major = beacon.major;
    minor = beacon.minor;
    
    CGFloat alpha = 1.0;
    switch (proximity) {
        case CLProximityUnknown:
            proximityString = @"CLProximityUnknown";
            alpha = 0.3;
            break;
        case CLProximityImmediate:
            proximityString = @"CLProximityImmediate";
            alpha = 1.0;
            break;
        case CLProximityNear:
            proximityString = @"CLProximityNear";
            alpha = 0.8;
            break;
        case CLProximityFar:
            proximityString = @"CLProximityFar";
            alpha = 0.5;
            break;
        default:
            break;
    }
    
    self.uuidLabel.text = beacon.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", minor];
    //self.proximityLabel.text = proximityString;
    self.accuracyLabel.text = [NSString stringWithFormat:@"%f", locationAccuracy];
    //self.rssiLabel.text = [NSString stringWithFormat:@"%d", rssi];
    
    if ([minor isEqualToNumber:@1]) {
        // Beacon A
        //self.beaconLabel.text = @"A";
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0.749 blue:1.0 alpha:alpha];
    } else if ([minor isEqualToNumber:@2]) {
        // Beacon B
        //self.beaconLabel.text = @"B";
        self.view.backgroundColor = [UIColor colorWithRed:0.604 green:0.804 blue:0.196 alpha:alpha];
    } else if ([minor isEqualToNumber:@3]) {
        // Beacon C
        //self.beaconLabel.text = @"C";
        self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.412 blue:0.706 alpha:alpha];
    } else {
        //self.beaconLabel.text = @"-";
        self.view.backgroundColor = [UIColor colorWithRed:0.663 green:0.663 blue:0.663 alpha:1.0];
    }
    
    if (minor != nil && self.currentMinor != nil && ![minor isEqualToNumber:self.currentMinor]) {
        //[self playSound:@"change"];
    }
    self.currentMinor = minor;
     */
    
    
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription message: error.localizedRecoverySuggestion delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    */
    
    
    if(error != nil){
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Beacon error",nil) message:NSLocalizedString(@"Please turn on BlueTooth And turn off Airpane Mode.",nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    }
    

}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"kCLAuthorizationStatusRestricted");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"kCLAuthorizationStatusDenied");
            break;
        case kCLAuthorizationStatusAuthorized:
            NSLog(@"kCLAuthorizationStatusAuthorized");
            break;
        default:
            break;
    }
}

- (void)sendNotification:(NSString*)message
{
    // 通知を作成する
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = [[NSDate date] init];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.alertBody = message;
    notification.alertAction = @"Open";
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    // 通知を登録する
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)AddressBtntap:(id)sender {
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) { // 未設定
        ABAddressBookRef book;
        ABAddressBookRequestAccessWithCompletion(book, ^(bool granted, CFErrorRef error) {
            
        });
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted ||
               ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) { // 拒否
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Notice",nil) message:NSLocalizedString(@"Your iPhone don't allow to access AddressBook. Please Access Setting>>Privacy>>Contacts and allow.",nil)
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) { // 許可
        
        ABRecordRef person = ABPersonCreate();
        CFErrorRef error = NULL;
        
        // 電話番号
        ABMutableMultiValueRef phone =
        ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(phone,CFBridgingRetain(_IDField.text), kABPersonPhoneMainLabel, NULL);
        ABRecordSetValue(person,
                         kABPersonPhoneProperty, phone, &error);
        CFRelease(phone);
        
        ABUnknownPersonViewController *view = [[ABUnknownPersonViewController alloc] init];
        view.unknownPersonViewDelegate = self;
        view.displayedPerson = person;
        [self.navigationController pushViewController:view animated:YES];
        
    }

    

    
}

- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownCardViewController didResolveToPerson:(ABRecordRef)person{
    
    
}


- (IBAction)FacebookBtnTap:(id)sender {
    
    
    NSString *urlString = @"https://www.facebook.com/app_scoped_user_id/";
    NSString *str = [self.IDField.text substringFromIndex:2];
    urlString = [NSString stringWithFormat:@"%@%@",urlString,str];
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@",urlString);
    
    // ブラウザを起動する
    [[UIApplication sharedApplication] openURL:url];

    
}
@end
