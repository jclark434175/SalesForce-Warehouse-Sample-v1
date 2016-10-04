public class testsecuirtyTask{
    static testMethod void testsecuirtyTask(){
        TestDataHelper testData = new TestDataHelper();
        String mktId = '123456';
        User ldrUsr = testData.createLeaderUser(mktId);
        User zoneUsr = testData.createZoneUser('Z'+mktId);
        User divUsr = testData.createDivUser('D'+mktId);
        User mktAdmin = testData.createMarketAdminUser('MXX');
        testData.market.Market_Administrator__c = mktAdmin.Id;
        update testData.market;

        //User stdUsr = testData.createUser('TEST','XX','Standard Platform User');
        User stdUsr = testData.createUser('TEST','YY','Standard Platform User');
        //stdUsr.MRKT_ID__c = 'YY';
        //update stdUsr;   
        
        Task t1;
        List<Task> taskList ;
        System.runAs(ldrUsr){
            t1 = new Task(Subject='Leader Task to Anybody', ownerid = stdUsr.id,
                    Status='In Progress',Priority='Normal',CurrencyIsoCode='USD');
            try{
                insert t1;
            }catch(Exception ex){
            }

            t1 = new Task(Subject='Leader Task to Mkt Admin', ownerid = mktAdmin.id,
                    Status='In Progress',Priority='Normal',CurrencyIsoCode='USD');
            try{
                insert t1;
            }catch(Exception ex){
            }
            System.debug('>>>>>>>>>>> task inserted='+t1);
            taskList= [select Id,Subject from Task where OwnerId=:stdUsr.Id];
        }
        taskList= [select Id,Subject from Task where OwnerId=:stdUsr.Id];
        //System.assert(taskList.size()==0) ;

        System.runAs(zoneUsr){
            t1 = new Task(Subject='Zone User to Ant User', ownerid = stdUsr.id,
                    Status='In Progress',Priority='Normal',CurrencyIsoCode='USD');
            try{
                insert t1;
            }catch(Exception ex){
            }

            t1 = new Task(Subject='Zone User Task to Mkt Admin', ownerid = mktAdmin.id,
                    Status='In Progress',Priority='Normal',CurrencyIsoCode='USD');
            try{
                insert t1;
            }catch(Exception ex){
            }

        }
        taskList= [select Id,Subject from Task where OwnerId=:stdUsr.Id];
        //System.assert(taskList.size()==0) ;


        System.runAs(divUsr){
            t1 = new Task(Subject='Leader Task to Mkt Admin', ownerid = stdUsr.id,
                    Status='In Progress',Priority='Normal',CurrencyIsoCode='USD');
            try{
                insert t1;
            }catch(Exception ex){
                System.debug('>>>>>>>>>> ERROR INSERTING Task to MKT ADMIN');
            }
            t1 = new Task(Subject='Zone User Task to Mkt Admin', ownerid = mktAdmin.id,
                    Status='In Progress',Priority='Normal',CurrencyIsoCode='USD');
            try{
                insert t1;
            }catch(Exception ex){
            }
        }
        taskList= [select Id,Subject from Task where OwnerId=:stdUsr.Id];
        //System.assert(taskList.size()==0) ;

        taskList= [select Id,Subject from Task where OwnerId=:mktAdmin.Id];
        System.assert(taskList.size()==3) ;
        System.runAs(mktAdmin){
            t1 = new Task(Subject='Leader Task to Mkt Admin', ownerid = stdUsr.id,
                    Status='In Progress',Priority='Normal',CurrencyIsoCode='USD');
            try{
                insert t1;
            }
            catch(Exception ex){
                System.debug('>>>>>>>>>> ERROR INSERTING Task to MKT ADMIN');
            }
        }
        taskList = [select Id,Subject from Task where OwnerId=:stdUsr.Id];
        System.debug('**********'+ taskList.size());
        //System.assert(taskList.size()==0) ;


    }
}
			                            	