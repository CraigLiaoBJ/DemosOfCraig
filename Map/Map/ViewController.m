//
//  ViewController.m
//  Map
//
//  Created by Craig Liao on 15/8/27.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

// CoreLocation是定位的框架
@interface ViewController ()<CLLocationManagerDelegate>

// 如果要实现定位功能 需要遵守 CLLocationManagerDelegate
//CLLocationManager实现定位功能
@property (nonatomic, strong) CLLocationManager *manager;
//CLGeocoder做的是地理编码， 反编码
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation ViewController

- (CLLocationManager *)manager{
    if (_manager == nil) {
        self.manager = [CLLocationManager new];
    }
    return _manager;
}

- (CLGeocoder *)geocoder{
    if (_geocoder == nil) {
        self.geocoder = [CLGeocoder new];
    }
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置程序什么时候使用定位功能
    [self.manager requestAlwaysAuthorization];
    // 指定代理人
    self.manager.delegate = self;
    // 开始定位
    [self.manager startUpdatingLocation];
    
//    [self.geocoder geocodeAddressString:@"北京市海淀区" completionHandler:^(NSArray *placemarks, NSError *error) {
//        
//        //这里获取经纬度
//        CLPlacemark *placemark = placemarks.firstObject;
//        
//        NSLog(@"%f   %f", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
//        
//    }];
    
    //地理信息反编码
    CLLocation *location = [[CLLocation alloc] initWithLatitude:40 longitude:110];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = placemarks.firstObject;
        NSLog(@"name == %@", placemark.addressDictionary);
        
    }];
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    CLLocation *location = locations.firstObject;
//    
//    NSLog(@"%f   %f", location.coordinate.latitude, location.coordinate.longitude);
//}


- (void)didReceiveMemoryWarning{
    
}

@end
