@isTest
public class ProjectsVisibilityTriggerTest {
  @isTest
  static void testProjectsVisibilityTrigger() {

    Projects__c testProject = new Projects__c();
    insert testProject;
    Projects_Member__c testPM = new Projects_Member__c();
    testPM.User__c = '0058a00000LfTxQAAV';
    testPM.Projects__c = testProject.Id;

    insert testPM;
    testProject.Status__c = 'New';
    update testProject;

    testProject.Status__c = 'Assigned';
    update testProject;
      
    testProject.Status__c = 'Completed';
    update testProject;

  }
}