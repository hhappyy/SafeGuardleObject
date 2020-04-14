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
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testString];
}


- (void)testArray {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"11", @"33", nil];
    NSLog(@"1:%@", array[1]);
    NSLog(@"2:%@", [array objectAtIndex:2]);
    NSLog(@"3:%@", [array objectAtIndex:3]);
}

- (void)testDictionary {
    
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
