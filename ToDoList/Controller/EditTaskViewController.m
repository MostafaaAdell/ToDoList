//
//  EditTaskViewController.m
//  ToDoList
//
//  Created by Mustafa on 30/08/2023.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIView *editButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *saveEditButtonOutlet;
@property (weak, nonatomic) IBOutlet UITextField *namrTextField;
@property (weak, nonatomic) IBOutlet UITextField *descTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegment;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateSet;
@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _modelNetwork = [ModelNetwork new];
    
    _namrTextField.text = _taskDetails.name;
    _descTextField.text = _taskDetails.desc;
    _prioSegment.selectedSegmentIndex = _taskDetails.prio;
    _statusSegment.selectedSegmentIndex = _taskDetails.status;
    _dateSet.date = _taskDetails.date;
    [_modelNetwork loadModeList];
    
    [self disableEditing];
     
    if(_modelNetwork.flag == 2){
        _editButton.hidden = YES;
        _saveEditButtonOutlet.hidden = YES;
        _editButton.enabled = NO;
        _saveEditButtonOutlet.enabled = NO;
        
    }

}


-(void)allowEditing{
    
    _namrTextField.enabled = YES;
    _descTextField.enabled =YES;
    _prioSegment.enabled = YES;
    _statusSegment.enabled = YES;
    _dateSet.enabled = YES;

}
-(void)disableEditing{
    
    _namrTextField.enabled = NO;
    _descTextField.enabled =NO;
    _prioSegment.enabled = NO;
    _statusSegment.enabled = NO;
    _dateSet.enabled = NO;

    
}
- (IBAction)editAction:(id)sender {
    [self allowEditing];
    if(_modelNetwork.flag == 1){[_statusSegment setEnabled:NO forSegmentAtIndex:0];}
   
}
- (IBAction)saveEditAction:(id)sender {
     _taskDetails.name =  _namrTextField.text ;
     _taskDetails.desc = _descTextField.text ;
     _taskDetails.prio = (int)_prioSegment.selectedSegmentIndex ;
     _taskDetails.status = (int)_statusSegment.selectedSegmentIndex ;
     _taskDetails.date = _dateSet.date ;
    _modelNetwork.modelList[_taskDetails.idNum] = _taskDetails;
    [_modelNetwork.toDoAppTasks removeObjectForKey:@"List"];
    [_modelNetwork setModelList];
    [self.navigationController popViewControllerAnimated:true];
}



@end
