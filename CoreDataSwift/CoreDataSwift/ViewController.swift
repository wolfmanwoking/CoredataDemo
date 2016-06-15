//
//  ViewController.swift
//  CoreDataSwift
//
//  Created by zhangpei on 16/6/16.
//  Copyright © 2016年 ivan. All rights reserved.
//


import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createBtn()
        
    }
    
    func createBtn(){
        
        var getArr = [ "增", "删", "改", "查" ];
        
        var btnY:CGFloat = 50;
        
        for var index = 0; index < getArr.count; ++index {
            
            var button:UIButton = UIButton(type:.Custom )
            button.frame = CGRectMake(10, btnY, 100, 30)
            button.tag = 100 + index
            button.backgroundColor = UIColor.redColor()
            button.setTitle( getArr[index], forState:UIControlState.Normal )
            self.view.addSubview(button);
            button.addTarget(self,action:#selector(clickBtn(_:)), forControlEvents:.TouchUpInside)
            
            btnY += button.frame.size.height + 10
            
        }
    }
    
    func clickBtn(btn:UIButton){
        switch ( btn.tag ) {
        case 100:
                clickBtnAdd ();
                break;
            
        case 101:
                clickBtnDelete ();
                break;
            
        case 102:
                clickBtnUpdate ();
                break;
            
        case 103:
                clickBtnSelect ();
                break;
        default:
            break;
        }
    }
    
    
    func clickBtnAdd(){
        let getAge: Int = Int( arc4random() % 1000 );
        let app = UIApplication.sharedApplication().delegate as! AppDelegate;
        let context = app.managedObjectContext
        
        let dog = NSEntityDescription.insertNewObjectForEntityForName( "Dog", inManagedObjectContext:  context ) as! Dog;
        dog.name = "狗";
        dog.age = String(getAge);
        dog.sex = "男";
        
        //保存
        do {
            try context.save()
            print("保存成功！")
        } catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    
    func clickBtnDelete() {
        //获取管理的数据上下文 对象
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        
        //声明数据的请求
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("Dog", inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        let predicate = NSPredicate( format: "name= '狗'" )
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            
            //遍历查询的结果
            for info:Dog in fetchedObjects as! [Dog]{
                //删除对象
                print("\nname=\(info.name)")
                print("sex=\(info.sex)")
                print("age=\(info.age)")
                
                context.deleteObject(info)
            }
            
            //重新保存-更新到数据库
            try context.save()
            
        }
        catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    func clickBtnUpdate() {
        //获取管理的数据上下文 对象
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        
        //声明数据的请求
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("Dog", inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        let predicate = NSPredicate( format: "sex = '男'" )
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            
            //遍历查询的结果
            for info:Dog in fetchedObjects as! [Dog]{
                print("\nname=\(info.name)")
                print("sex=\(info.sex)")
                print("age=\(info.age)")
                
                info.sex = "女";
            }
            try context.save()
        }
        catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    
    func clickBtnSelect() {
        //获取管理的数据上下文 对象
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        
        //声明数据的请求
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("Dog", inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
//        let predicate = NSPredicate(format: "sex= '男' " )
//        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            
            if ( fetchedObjects?.count != 0 ) {
                //遍历查询的结果
                for info:Dog in fetchedObjects as! [Dog]{
                    print("\nname=\(info.name)")
                    print("sex=\(info.sex)")
                    print("age=\(info.age)")
                }
            }else{
                print( "没有查到数据" )
            }
            
            
        }
        catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

