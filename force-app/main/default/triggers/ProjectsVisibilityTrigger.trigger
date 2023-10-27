trigger ProjectsVisibilityTrigger on Projects__c(after update) {
  String PrContact = [
    SELECT User__c
    FROM Projects_Member__c
    WHERE Projects__c IN :Trigger.new
  ]
  .User__c;

  List<Projects__Share> PsList = [Select Id From Projects__Share Where UserOrGroupId = :PrContact AND ParentId IN :Trigger.New];

  for (Projects__c PsNew : Trigger.new) {    
    for (Projects__c PsOld : Trigger.Old) {
      if (PsOld.Status__C != 'Assigned' && PsNew.Status__C == 'Completed') {
        PsNew.addError('Follow the path in order to complete');
      }
      if (PsNew.Status__C == 'Completed') {
          for(Projects__Share PS : PsList){
              delete PS;
          }            
      } else {
            Projects__Share PsShareNew = new Projects__Share();
            PsShareNew.ParentId = PsNew.Id;
            PsShareNew.UserOrGroupId = PrContact;
            PsShareNew.AccessLevel = 'edit';
            PsShareNew.RowCause = 'Manual'; 
            insert PsShareNew;        
      }
    }
  }
}