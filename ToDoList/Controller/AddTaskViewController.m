//
//  AddTaskViewController.m
//  ToDoList
//
//  Created by Mustafa on 30/08/2023.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController (){
  //  NSUserDefaults *dataListDefault;
    Model *modelList;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegment;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateSet;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _modelNetwork = [ModelNetwork new];
     modelList = [Model new];
    [_modelNetwork loadModeList];
  
}
- (IBAction)saveTask:(id)sender {
    
    [_modelNetwork.toDoAppTasks removeObjectForKey:@"List"];
    modelList.name = _nameTextField.text;
    modelList.desc = _descTextField.text;
    modelList.prio = (int)_priSegment.selectedSegmentIndex;
    modelList.status = (int)_statusSegment.selectedSegmentIndex;
    modelList.date = _dateSet.date;
    modelList.idNum = (int)_modelNetwork.modelList.count;
    [_modelNetwork.modelList addObject:modelList];
    [_modelNetwork setModelList];
    [self.navigationController popViewControllerAnimated:true];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
