global class ScheduleManagerOpp implements Schedulable {
   global void execute(SchedulableContext sc) {

      ManagerOppBatch mob = new ManagerOppBatch();
    Id batchId = Database.executeBatch(mob);
   }
}