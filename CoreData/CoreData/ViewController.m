//
//  ViewController.m
//  CoreData
//
//  Created by zhangpei on 16/6/15.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ViewController.h"

#import <CoreData/CoreData.h>
#import "Dog.h"
#import "AppDelegate.h"


@interface ViewController ()
{
    AppDelegate * app;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    app = [[UIApplication sharedApplication] delegate];
    
    [self createButton];
    
}


-(void)createButton
{
    
    NSArray * arr = [NSArray arrayWithObjects: @"增", @"删", @"改", @"查", nil ];
    
    NSInteger btnY = 50;
    for ( NSInteger i = 0 ; i < arr.count; i++ ) {
        UIButton * btn = [UIButton buttonWithType: UIButtonTypeCustom ];
        btn.frame = CGRectMake( 10, btnY, 100, 100 );
        btn.backgroundColor = [UIColor redColor];
        btn.tag = 100 + i;
        [btn addTarget: self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside ];
        [btn setTitle: [NSString stringWithFormat:@"%@", [arr objectAtIndex: i ]] forState:UIControlStateNormal ];
        [self.view addSubview: btn ];
        btnY += btn.frame.size.height + 10;
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickBtn:(UIButton *)btn
{
    switch ( btn.tag ) {
        case 100:
        {
            [self clickBtnAdd];
            
            break;
        }
        case 101:
        {
            [self clickBtnDelete];
            
            break;
        }
        case 102:
        {
            [self clickBtnUpdate];
            
            break;
        }
        case 103:
        {
            [self clickBtnSelect];
            
            break;
        }
        default:
            break;
    }
    
}


-(void)clickBtnAdd
{
    int getAge = arc4random() % 1000;
    
    Dog * dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:app.managedObjectContext ];
    dog.name = [NSString stringWithFormat:@"狗狗%d", getAge ];
    dog.age = [NSString stringWithFormat:@"狗%d", getAge ];
    dog.sex = [NSString stringWithFormat:@"%@狗狗", (getAge % 2) ? @"男" : @"女" ];
    
    [app.managedObjectContext save: nil ];
    
}

-(void)clickBtnDelete
{
    NSEntityDescription * getEntityDescription = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext: app.managedObjectContext ];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity: getEntityDescription ];
    
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name=%@", @"花花" ];
    [request setPredicate: predicate ];
    
    NSArray * getArr = (NSArray *)[app.managedObjectContext executeFetchRequest: request error: nil ];
    
    if ( getArr.count ) {
        for ( Dog * dog in getArr ) {
            NSLog( @"dog--name==%@", dog.name );
            NSLog( @"dog--sex==%@", dog.sex );
            NSLog( @"dog--age==%@", dog.age );
            
            [app.managedObjectContext deleteObject: dog ];
        }
        [app.managedObjectContext save: nil ];
        NSLog( @"删除完成" );
        
    }else{
        NSLog( @" 没有查到 " );
        
    }
}

-(void)clickBtnUpdate
{
    NSEntityDescription * getEntityDescription = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext: app.managedObjectContext ];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity: getEntityDescription ];
    
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name!=%@", @"小花狗" ];
    [request setPredicate: predicate ];
    
    NSArray * getArr = (NSArray *)[app.managedObjectContext executeFetchRequest: request error: nil ];
    
    if ( getArr.count ) {
        for ( Dog * dog in getArr ) {
            NSLog( @"dog--name==%@", dog.name );
            NSLog( @"dog--sex==%@", dog.sex );
            NSLog( @"dog--age==%@", dog.age );
            dog.name = @"小花狗";
            dog.sex = @"0";
            dog.age = @"0";
        }
        [app.managedObjectContext save: nil ];
        NSLog( @"修改完成" );
        
    }else{
        NSLog( @" 没有查到 " );
        
    }
    
}

-(void)clickBtnSelect
{
    NSEntityDescription * getEntityDescription = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext: app.managedObjectContext ];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity: getEntityDescription ];
    
    NSArray * getArr = [app.managedObjectContext executeFetchRequest: request error: nil ];
    
    if ( getArr.count != 0 ) {
        
        for ( Dog * dog in getArr ) {
            NSLog( @"\n\ndog--name==%@", dog.name );
            NSLog( @"dog--sex==%@", dog.sex );
            NSLog( @"dog--age==%@", dog.age );
        }
    }
    
}







@end
