//
//  ViewController.h
//  ToDoList
//
//  Created by Mustafa on 30/08/2023.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface TODoListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property NSMutableArray<Model*> *modelList;


@end

