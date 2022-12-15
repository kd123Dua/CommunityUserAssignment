/**
 * @description       : This is a test class used to test my main user CommunityUserCreationclass
 * @author            : Concret.io
 * @group             : 
 * @last modified on  : 12-15-2022
 * @last modified by  : Concret.io
**/
@isTest
private with sharing class CommunityUserCreationTestClass {
     
    @isTest
    static void  contact_Without_Account()
     {
        Contact newContact = new Contact(FirstName = 'Mukund', LastName = 'Sharma');
        INSERT newContact;
 
        Test.startTest();
        try{
        UserCreationClass.createUser(newContact.Id);
        }
        catch(Exception e)
        {}
        Test.stopTest();
 
        List<User> userList = [SELECT id FROM User WHERE contactId =: newContact.Id];
        System.assertEquals(0, userList.size());
    }
 
    @isTest
    static void  createCommunityUser()
     {
        Account newAccount = new Account(Name = 'Karan dua');
        INSERT newAccount;
 
        Contact newContact = new Contact(FirstName = 'Mukund', LastName = 'Sharma', Email = 'Mukund@gmail.com', AccountId = newAccount.Id);
        INSERT newContact;
 
        Test.startTest();
        try{
        UserCreationClass.createUser(newContact.Id);
         }
        catch(Exception e){}
        Test.stopTest();
        List<User> userList = [SELECT id,FirstName,LastName FROM User WHERE contactId =: newContact.Id];
        System.assertEquals(1, userList.size() );
        System.assertEquals(newContact.FirstName,userList[0].FirstName,'FirstName of user and contact should be same');
        System.assertEquals(newContact.LastName,userList[0].LastName,'LastName of user and contact should be same');
 
    }

    @isTest
    static void  contact_Without_Mail()
     {
        Account newAccount = new Account(Name = 'Karan dua');
        INSERT newAccount;
 
        Contact newContact = new Contact(FirstName = 'Mukund', LastName = 'Sharma', AccountId = newAccount.Id);
        INSERT newContact;
 
        Test.startTest();
        try{
        UserCreationClass.createUser(newContact.Id);
        }
        catch(Exception e){}
        Test.stopTest();
 
        List<User> userList = [SELECT Id FROM User WHERE ContactId =: newContact.Id];
        System.assertEquals(0, userList.size(),'No user should be formed without mail');

    }
   
    @isTest
    static void  createUsersdoubleInContact()
     {
        Account newAccount = new Account(Name = 'Karan dua');
        INSERT newAccount;
 
        Contact newContact = new Contact(FirstName = 'Mukund', LastName = 'Sharma', Email = 'Mukund@gmail.com', AccountId = newAccount.Id);
        INSERT newContact;
 
         try{
            UserCreationClass.createUser(newContact.Id);
            }
         catch(Exception e){}
        List<User> userList = [SELECT id FROM User WHERE contactId =: newContact.Id];
        System.assertEquals(1, userList.size() );
       
        Test.startTest();
        try{
        UserCreationClass.createUser(newContact.Id);
        }
        catch(Exception e){}
        Test.stopTest();
 
        List<User> userList1 = [SELECT id FROM User WHERE contactId =: newContact.Id];
        System.assertEquals(1, userList1.size() );
    }
}

