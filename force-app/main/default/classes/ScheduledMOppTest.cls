@IsTest
private class ScheduledMOppTest {
  public static String CRON_EXP = '0 0 0 29 10 ? 2023';
  @IsTest
  static void testScheduledJob() {
    List<AsyncApexJob> jobsBefore = [
      SELECT Id, ApexClassID, ApexClass.Name, Status, JobType
      FROM AsyncApexJob
    ];
    System.assertEquals(0, jobsBefore.size(), 'not expecting any asyncjobs');

    Test.startTest();
    // Schedule the test job
    String jobId = System.schedule(
      'ScheduleManagerOpp',
      CRON_EXP,
      new ScheduleManagerOpp()
    );
    Test.stopTest();
    List<AsyncApexJob> jobsScheduled = [
      SELECT Id, ApexClassID, ApexClass.Name, Status, JobType
      FROM AsyncApexJob
      WHERE JobType = 'ScheduledApex'
    ];
    System.assertEquals(1, jobsScheduled.size(), 'expecting one scheduled job');
    System.assertEquals(
      'ScheduleManagerOpp',
      jobsScheduled[0].ApexClass.Name,
      'expecting specific scheduled job'
    );

    // check apex batch is in the job list
    List<AsyncApexJob> jobsApexBatch = [
      SELECT Id, ApexClassID, ApexClass.Name, Status, JobType
      FROM AsyncApexJob
      WHERE JobType = 'BatchApex'
    ];
    System.assertEquals(
      1,
      jobsApexBatch.size(),
      'expecting one apex batch job'
    );
    System.assertEquals(
      'ManagerOppBatch',
      jobsApexBatch[0].ApexClass.Name,
      'expecting specific batch job'
    );
  }
}