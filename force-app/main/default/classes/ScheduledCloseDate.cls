global class ScheduledCloseDate implements Schedulable {
   global void execute(SchedulableContext sc) {

      CloseDateChecker cdd = new CloseDateChecker();
    Id batchId = Database.executeBatch(cdd);
   }
}