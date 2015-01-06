//
//  SenderViewController.m
//  AddTest
//
//  Created by 横関秀樹 on 2014/04/30.
//  Copyright (c) 2014年 Hideki yokozeki. All rights reserved.
//

#import "SenderViewController.h"

@interface SenderViewController (){
    NSTimer* timer;
    NSTimer* A_timer;
    NSInteger counter;
    BOOL StartFlag;
    
    UIActivityIndicatorView *indicator;
    
}

@end

@implementation SenderViewController

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
    
//       0 1 10 11 100 101 110 111 1000 1001 1010 1011 1100 1101 1110 1111
//       0 1 2  3  4   5   6   7   8    9    A    B    C    D    E    F
    
    /*
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:0.000 green:0.549 blue:0.890 alpha:1.000];
    */
          self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Back.png"]];

    self.proximityUUID = [[NSUUID alloc] initWithUUIDString:@"AE21BCE0-7655-4647-B492-A3F8DE2F9A02"];
    // CBPeripheralManagerを作成
    self.manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];

    counter = 0;
    StartFlag = YES;
    
    _Name = [NSString stringWithFormat:@"%@%@%@",_UserName,@"/",_Name];
    NSLog(@"test ==== %@",_UserName);

    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(time:)
                                            userInfo:nil
                                             repeats:YES];
    NSLog(@"%@",_Name);
    
    
    [self setanimation];
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor redColor];
    indicator.frame = CGRectMake(110, 250, 100, 100);
    
    // クルクルと回し始める
    [indicator startAnimating];
    
    // サブビューに追加する
    [self.view addSubview:indicator];
  
}

-(void)setanimation{

    
    /*回転アニメーション
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:(M_PI / 180) * 360];
    
    rotationAnimation.duration = 4.0f;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.view.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
    */
     
    /*
    sendAnimationView1 = [[UIView alloc] init];
    sendAnimationView2 = [[UIView alloc] init];
    sendAnimationView3 = [[UIView alloc] init];
    
    sendAnimationView1.frame = CGRectMake(135, 560, 0, 0);
    sendAnimationView2.frame = CGRectMake(135, 560, 0, 0);
    sendAnimationView3.frame = CGRectMake(135, 560, 0, 0);
    
    sendAnimationView1.backgroundColor = [UIColor blackColor];
    sendAnimationView2.backgroundColor = [UIColor blackColor];
    sendAnimationView3.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:sendAnimationView1];
    [self.view addSubview:sendAnimationView2];
    [self.view addSubview:sendAnimationView3];
    
    Anime_flag = YES;
    */
}

/*
-(void)ViewActiontime:(NSTimer*)timers{
    
    if(Anime_flag == YES){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.5];
        sendAnimationView1.frame = CGRectMake(0, 40, 50, 50);
        sendAnimationView2.frame = CGRectMake(135, 40, 50, 50);
        sendAnimationView3.frame = CGRectMake(270, 40, 50, 50);
        Anime_flag = NO;
        [UIView commitAnimations];

    }else{
        
        sendAnimationView1.frame = CGRectMake(160, 560, 0, 0);
        sendAnimationView2.frame = CGRectMake(160, 560, 0, 0);
        sendAnimationView3.frame = CGRectMake(160, 560, 0, 0);
        Anime_flag = YES;
    }
    
    



}
 */

-(void)time:(NSTimer*)timers{
    
    NSInteger major;
    NSInteger minor;
    
    if(counter == 0 && StartFlag == YES){
        
        if([self.sendDataName  isEqual: @"Line"]){
            major = 1;
            minor = 1;
        }else if([self.sendDataName  isEqual: @"Facebook"]){
            major = 2;
            minor = 2;
        
        }else{
            major = 3;
            minor = 3;
        }
        StartFlag = NO;
    
    }else if( counter >= _Name.length ){
        
        major = 0;
        minor = 0;
        counter = 0;
        StartFlag = YES;
    
    }else{
        
        major = [_Name characterAtIndex:counter];
        major = major << 8;
        counter++;
        
        if(counter < _Name.length){
            major = major + [_Name characterAtIndex:counter];
            counter++;
        }
        
        if(counter < _Name.length){
            minor = [_Name characterAtIndex:counter];
            counter++;
            minor = minor << 8;
            
            if(counter < _Name.length){
                minor = minor + [_Name characterAtIndex:counter];
                counter++;
            }
        }else{
            minor = 0;
        }
    }
        [self startAdvertising:major Getminor:minor];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.manager stopAdvertising];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)startAdvertising:(NSInteger)major Getminor:(NSInteger)minor
{
    
        // CLBeaconRegionを作成してアドバタイズするデータを取得
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.proximityUUID
                                                                           major:major
                                                                           minor:minor
                                                                      identifier:@"jp.classmethod.testregion"];
    
    NSDictionary *beaconPeripheralData = [beaconRegion peripheralDataWithMeasuredPower:nil];
    
    //    NSDictionary *beaconPeripheralData = [self beaconAdvertisement:self.proximityUUID
    //                                                             major:1
    //                                                             minor:minor
    //                                                     measuredPower:-58];
    
    [self.manager stopAdvertising];
    // アドバタイズを開始
    [self.manager startAdvertising:beaconPeripheralData];
}

- (NSDictionary *)beaconAdvertisement:(NSUUID *)proximityUUID
                                major:(uint16_t)major
                                minor:(uint16_t)minor
                        measuredPower:(int8_t)measuredPower  {
    NSString *beaconKey = @"kCBAdvDataAppleBeaconKey";
    
    unsigned char advertisementBytes[21] = {0};
    
    [self.proximityUUID getUUIDBytes:(unsigned char *)&advertisementBytes];
    
    advertisementBytes[16] = (unsigned char)(major >> 8);
    advertisementBytes[17] = (unsigned char)(major & 255);
    
    advertisementBytes[18] = (unsigned char)(minor >> 8);
    advertisementBytes[19] = (unsigned char)(minor & 255);
    
    advertisementBytes[20] = measuredPower;
    
    NSMutableData *advertisement = [NSMutableData dataWithBytes:advertisementBytes length:21];
    
    return [NSDictionary dictionaryWithObject:advertisement forKey:beaconKey];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    
    if(peripheral.state == 4){
        [indicator stopAnimating];
        self.Sending.text = @"Bluetooth OFF.";
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Notice",nil) message:NSLocalizedString(@"Your Bluetooth has been OFF. Please Access Setting>>Bluetooth and Turn ON.",nil)
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"CBPeripheralManagerStatePoweredOn");
            // まずはBeaconAを起動
            /*
             [self.firstSwitch setOn:YES];
             [self startAdvertising:1];
             */
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"CBPeripheralManagerStatePoweredOff");
            break;
        case CBPeripheralManagerStateResetting:
            NSLog(@"CBPeripheralManagerStateResetting");
            break;
        case CBPeripheralManagerStateUnauthorized:
            NSLog(@"CBPeripheralManagerStateUnauthorized");
            break;
        case CBPeripheralManagerStateUnknown:
            NSLog(@"CBPeripheralManagerStateUnknown");
            break;
        case CBPeripheralManagerStateUnsupported:
            NSLog(@"CBPeripheralManagerStateUnsupported");
            break;
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    
    self.sendDataName = @"";
    [self.manager stopAdvertising];
     [timer invalidate];
    
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

@end
