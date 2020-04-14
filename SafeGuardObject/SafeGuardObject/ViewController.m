//
//  ViewController.m
//  SafeGuardObject
//
//  Created by hapy on 2020/4/14.
//  Copyright © 2020 hapy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testDictionary];
}




- (void)testArray {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"11", @"33", nil];
    NSLog(@"1:%@", array[1]);
    NSLog(@"2:%@", [array objectAtIndex:2]);
    NSLog(@"3:%@", [array objectAtIndex:3]);
}

- (void)testDictionary {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"key1", @"value1", nil];
    NSLog(@"%@", dic[@"11"]);
    
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"key1", @"value1", nil];
    [muDic setValue:nil forKey:@"key2"];
    [muDic setObject:nil forKey:@"key2"];
    NSLog(@"%@", muDic[@"value"]);
}

- (void)testString {
    
    NSMutableString *muStr = [NSMutableString stringWithFormat:@"122"];
    NSString *str = [muStr substringWithRange:NSMakeRange(6, 3)];
    NSLog(@"%@", str);
    
    NSString *str1 = @"123";
    NSString *ss = [str1 substringWithRange:NSMakeRange(4, 5)];
    NSLog(@"%@", ss);
}


@end
