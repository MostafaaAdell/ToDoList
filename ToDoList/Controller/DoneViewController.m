//
//  DoneViewController.m
//  ToDoList
//
//  Created by Mustafa on 31/08/2023.
//



#import "DoneViewController.h"
#import "EditTaskViewController.h"


@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet UITableView *progressTableView;
@end

@implementation DoneViewController 

- (void)viewWillAppear:(BOOL)animated{
    

    _modelNetwork = [ModelNetwork new];
    [_modelNetwork loadModeList];
    [_modelNetwork filterDataAccordingToStatus:2 withPredicate:@"status == %d"];
    [_modelNetwork filterAccordingPriority];
    [_progressTableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modelNetwork = [ModelNetwork new];
    [_modelNetwork loadModeList];
    [_modelNetwork filterDataAccordingToStatus:2 withPredicate:@"status == %d"];
    [_modelNetwork filterAccordingPriority];

    

}



- (IBAction)sortButton:(UIBarButtonItem *)sender {
    
    _modelNetwork.isSort = _modelNetwork.isSort == 1 ? 0:1;
    [_modelNetwork loadModeList];
    [_modelNetwork filterDataAccordingToStatus:2 withPredicate:@"status == %d"];
    [_modelNetwork filterAccordingPriority];
    [_progressTableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(_modelNetwork.isSort){
        switch(section){
            case 0:
                return @"High Priority";
                break;
            case 1:
                return @"Meduim Priority";
                break;
            case 2:
                return @"Low Priority";
                break;
        }
    }
    else{return @"";}
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if(_modelNetwork.isSort){
        switch(section){
            case 0:
                return _modelNetwork.highPrioty.count;
                break;
            case 1:
                return _modelNetwork.meduimPrio.count;
                break;
            case 2:
                return _modelNetwork.lowPrio.count;
                break;
        }
    }
    else{return _modelNetwork.listView.count;}
     return _modelNetwork.listView.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_modelNetwork.isSort){
        return 3;
    }
      
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(_modelNetwork.isSort){
        switch(indexPath.section){
            case 0:
                cell.textLabel.text = _modelNetwork.highPrioty[indexPath.row].name;
                break;
            case 1:
                cell.textLabel.text = _modelNetwork.meduimPrio[indexPath.row].name;
                break;
            case 2:
                cell.textLabel.text = _modelNetwork.lowPrio[indexPath.row].name;
                break;
        }
        
    }else{cell.textLabel.text = _modelNetwork.listView[indexPath.row].name;}
    return cell;
}





- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sure" message:@"You Want Delete Task" preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                         handler:nil];
         [alert addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

              if (editingStyle == UITableViewCellEditingStyleDelete) {

                  [self->_modelNetwork removeCertainTaskWithIndex:(int)indexPath.row WithSection:(int)indexPath.section withStatus:2 withPredicate:@"status == %d"];
                     [self->_progressTableView reloadData];
            }

         }];
         
         [alert addAction:okAction];
         [self presentViewController:alert animated:true completion:nil];
        
        
    
        
           
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    EditTaskViewController *edittaskController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditTask"];
    edittaskController.modelNetwork.flag = 2;
    edittaskController.modelNetwork.modelList = _modelNetwork.modelList;
    if(_modelNetwork.isSort){
        switch(indexPath.section){
            case 0:
                edittaskController.taskDetails = _modelNetwork.highPrioty[indexPath.row];
                break;
            case 1:
                edittaskController.taskDetails = _modelNetwork.meduimPrio[indexPath.row];
                break;
            case 2:
                edittaskController.taskDetails = _modelNetwork.lowPrio[indexPath.row];
                break;
        }
    }
    else{edittaskController.taskDetails = _modelNetwork.listView[indexPath.row];}
    
    
    
    [self.navigationController pushViewController:edittaskController animated:true];
}

@end
